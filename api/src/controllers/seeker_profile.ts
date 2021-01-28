import { Request, Response } from "express";
import models from "../models";

export const getSeekerProfile = async(req: Request, res: Response)=>{
    const id = req.params.id 
    try {
        const profile = await models.SeekerProfile.findById(id)
        if(profile){
            return res.status(404).json({message: "there is not data with specified id"})
        }

        return res.status(200).json(profile)
    } catch (error) {
        return res.status(500).json({message: "there is an error"})
    }

}

export const updateSeekerProfile = async (req: Request, res: Response) => {
  const id = req.params.id;

  try {
    const seeker = await models.SeekerProfile.findByIdAndUpdate(id, {
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
