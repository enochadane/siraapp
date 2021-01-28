import { Request, Response } from "express";
import models from "../models";


export const getCompanyProfile = async(req: Request, res: Response)=>{
    const id = req.params.id 
    try {
        const profile = await models.CompanyProfile.findById(id)
        if(profile){
            return res.status(404).json({message: "there is not data with specified id"})
        }

        return res.status(200).json(profile)
    } catch (error) {
        return res.status(500).json({message: "there is an error"})
    }

}

export const updateCompanyProfile = async (req: Request, res: Response) => {
  const id = req.params.id;

  try {
    const company = await models.CompanyProfile.findByIdAndUpdate(id, {
      ...req.body,
    });
    if (!company) {
      return res.status(400).json({ message: "No company found" });
    }
    return res.status(201).json(company);
  } catch (error) {
    return res.status(400).json({ message: "Something went wrong" });
  }
};

export const deleteCompanyProfile = async (req: Request, res: Response) => {
  const id = req.params.id;
  try {
    const company = await models.CompanyProfile.findByIdAndDelete(id);

    if (!company) {
      return res.status(400).json({ message: "No company found" });
    }
    return res.status(201).json(company);
  } catch (error) {
    return res.status(400).json({ message: "Something went wrong" });
  }
};
