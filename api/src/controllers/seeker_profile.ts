import { Request, Response } from "express";
import models from "../models";

export const getSeekerProfile = async (req: Request, res: Response) => {
  const id = req.params.id;
  try {
    const profile = await models.SeekerProfile.findById(id);
    if (profile) {
      return res
        .status(404)
        .json({ message: "there is not data with specified id" });
    }

    return res.status(200).json(profile);
  } catch (error) {
    return res.status(500).json({ message: "there is an error" });
  }
};

export const updateSeekerProfile = async (req: Request, res: Response) => {
  const id = req.params.id;
  const { firstname, lastname, phone_number, summary, gender } = req.body;

  console.log(firstname, lastname, phone_number, summary, gender);
  if (!req.file) {
    console.log("No file is received");
    return res.status(400).json({ message: "No file is received" });
  }
  try {
    const seeker = await models.SeekerProfile.findByIdAndUpdate(id, {
      photo: req.file.filename,
      ...req.body,
    });
    if (!seeker) {
      return res.status(400).json({ message: "No user found" });
    }
    return res.status(201).json(seeker);
  } catch (error) {
    return res.status(400).json({ message: "Something went wrong" });
  }
};

export const deleteSeekerProfile = async (req: Request, res: Response) => {
  const id = req.params.id;
  try {
    const seeker = await models.SeekerProfile.findByIdAndDelete(id);

    if (!seeker) {
      return res.status(400).json({ message: "No user found" });
    }
    return res.status(201).json(seeker);
  } catch (error) {
    return res.status(400).json({ message: "Something went wrong" });
  }
};

export const postResume = async (req: Request | any, res: Response) => {
  if (!req.file) {
    console.log("No file is received");
    return res.status(400).json({ message: "No file is received" });
  }
  try {
    const logged_in_user_id = req.user._id.toString();
    const { user_id } = req.body;
    if (user_id !== logged_in_user_id) {
      return res.status(403).json({ message: "UnAuthorized Operation" });
    }
    const updatedSeeker = await models.SeekerProfile.findOneAndUpdate({user_id}, {resume_url: req.file.filename})
  
    if (!updatedSeeker) {
      return res.status(400).json({ message: "No user found" });
    }
    return res.status(201).json(updatedSeeker);
  } catch (error) {
    return res.status(400).json({ message: "Something went wrong" });
  }
};
