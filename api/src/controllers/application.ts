import { Request, Response } from "express";
import models from "../models";
import { IApplication } from "../models/application";
import { ICompanyProfile } from "../models/campany_profile";
import { ISeekerProfile } from "../models/seeker_profile";

export const getApplication = async (req: Request, res: Response) => {
  const application_id = req.params.id;

  try {

    const application = await models.Application.findById(
      application_id
      ).populate({
        path: "applicant_id"
      })
     

    // const application = await models.Application.findById(
    //   application_id
    // ).populate({
    //   path: "applicant_id",
    //   // as: "applicant",
    //   // model: "User",
    //   // select: "role email ",
    //   populate:{
    //     path: "_id",
    //     as: "user_id",  
    //     model: "Seeker", 
    //   }
    // });
    if (!application) {
      return res
        .status(404)
        .json({ message: "There is not data of the given application id" });
    }
    let profile: ISeekerProfile;
    if (application) {
      const applicant_id = application?.applicant_id;
      models.SeekerProfile.findOne({ user_id: applicant_id }).exec((err, prof)=>{
        if (!prof || err){
          return res
          .status(404)
          .json({ message: "There is not data of the given application id" });
        }else{
          profile = prof;
          return res.status(200).json({application, profile});
        }
      });
      
    }else{
      return res
        .status(404)
        .json({ message: "There is not data of the given application id" });
    }

  } catch (error) {
    return res.status(404).json({ message: "There is an error on applicaton" });
  }
};

export const applyForJob = async (req: Request, res: Response) => {
  const { applicant_id, job_id, company_id, other_info } = req.body;

  try {
    const application = await models.Application.create({
      applicant_id,
      job_id,
      other_info,
      company_id,
    });

    if (!application) {
      return res
        .status(403)
        .json({ message: "There is an error on creating application" });
    }
    return res.status(200).json(application);
  } catch (error) {
    return res.status(404).json({ message: "There is an error on applicaton" });
  }
};

export const getApplicationWithCompanyId = async (
  req: Request,
  res: Response
) => {
  const company_id = req.params.company_id;

  try {
    const applications = await models.Application.find({ company_id });

    if (!applications) {
      return res
        .status(404)
        .json({ message: "There is not data of the given company id" });
    }

    return res.status(200).json(applications);
  } catch (error) {
    return res.status(404).json({ message: "There is an error on applicaton" });
  }
};
