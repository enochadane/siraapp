import { Request, Response } from "express";
import models from "../models";
import { IUser } from "../models/user";

export const getUserProfile = async (req: Request, res: Response) => {
  const username = req.params.username.toLowerCase();
  console.log(username, " is username");
  try {
    const user: IUser | null = await models.User.findOne({ username }).populate("Role");
    if (user) {
      let userProfile;
      if (user.role_id.name === "SEEKER") {
        userProfile = await models.SeekerProfile.findOne({
          user_id: user._id,
        }).populate("user_id", "email");
      } else if (user.role_id.name === "EMPLOYER") {
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


export const getUsers = async (req: Request, res: Response) => {
  try {
    const users = await models.User.find({}).populate("role_id", "_id name");
    if (users) {
      return res.status(200).json(users);
    } else {
      return res.status(400).json({ message: "No user found" });
    }
  } catch (error) {
    return res.status(400).json({ message: "Something went wrong" });
  }
};

export const getUser = async (req: Request, res: Response) => {
  const role_id = req.params.id;
  try {
    const user = await models.User.findById(role_id).populate("role_id", "_id name");
    if (user) {
      return res.status(200).json(user);
    } else {
      return res.status(400).json({ message: "No user found" });
    }
  } catch (error) {
    return res.status(400).json({ message: "Something went wrong" });
  }
};

export const updateUser = async (req: Request, res: Response) =>{
  const id = req.params.id;
  try {
    const user = await models.User.findByIdAndUpdate(id, {
      ...req.body,
    });
    if (!user) {
      return res.status(400).json({ message: "No user found" });
    }
    return res.status(201).json(user);
  } catch (error) {
    return res.status(400).json({ message: "Something went wrong" });
  }
}

export const deleteUser = async (req: Request, res: Response) =>{
  const id = req.params.id;
  try {
    const user = await models.User.findByIdAndDelete(id);
    if (!user) {
      return res.status(400).json({ message: "No user found" });
    }
    return res.status(201).json(user);
  } catch (error) {
    return res.status(400).json({ message: "Something went wrong" });
  }
}

export const changeUserRole = async (req: Request, res: Response) =>{
  const id = req.params.id;

  try {
    const user = await models.User.findByIdAndUpdate(id, {
      role_id: req.body.role_id,
    });
    if (!user) {
      return res.status(400).json({ message: "Role Updating Error" });
    }
    return res.status(201).json(user);
  } catch (error) {
    return res.status(400).json({ message: "Something went wrong" });
  }
}