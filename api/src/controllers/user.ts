import { Request, Response } from "express";
import models from "../models";
import { IUser } from "../models/user";

export const getUserProfile = async (req: Request, res: Response) => {
  const username = req.params.username.toLowerCase();
  console.log(username, " is username");
  try {
    const user: IUser | null = await models.User.findOne({ username });
    if (user) {
      let userProfile;
      if (user.role?.toString() === "SEEKER") {
        userProfile = await models.SeekerProfile.findOne({
          user_id: user._id,
        }).populate("user_id", "email");
      } else if (user.role?.toString() === "EMPLOYER") {
        userProfile = await models.CompanyProfile.findOne({
          user_id: user._id,
        }).populate("user_id", "email");
      }
      return res.status(200).json(userProfile);
    } else {
      return res.status(400).json({ message: "No user found" });
    }
  } catch (error) {
    return res.status(400).json({ message: "Something went wrong" });
  }
};
