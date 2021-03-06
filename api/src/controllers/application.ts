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
  console.log('in the post apply function');
  const { applicant_id, job_id, company_id, first_name, last_name, phone, email, other_info } = req.body;

  try {
    const application = await models.Application.create({
      applicant_id,
      job_id,
      company_id,
      first_name,
      last_name,
      phone,
      email,
      other_info,
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

export const getApplicationsWithJobId = async (
  req: Request,
  res: Response
) => {
  const job_id = req.params.job_id;

  try {
    const applications = await models.Application.find({ job_id });

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

export const getApplicationsWithApplicantId = async (
  req: Request,
  res: Response
) => {
  const applicant_id = req.params.applicant_id;

  try {
    const applications = await models.Application.find({ applicant_id });

    if (!applications) {
      return res
      .status(404)
      .json({message: "Can't find applications with the given applicant id"});
    }

    return res.status(200).json(applications);
  } catch (error) {
    return res.status(404).json({ message: "Error in fetching application"});
  }
};

export const updateApplication = async (req: Request | any, res: Response) => {
  const {
    job_id,
    applicant_id,
    company_id,
    first_name,
    last_name,
    phone,
    email,
    other_info,
  } = req.body;

  try {
    const application_id = req.params.id;
    const application = await models.Application.findByIdAndUpdate(
      application_id, {
        first_name,
        last_name,
        phone,
        email,
        other_info,
      }
    );
    if(!application) {
      return res.status(403).json({ message: "There is an error in updating application" });
    }
    return res.status(201).json(application);
  } catch (error) {
    return res.status(404).json({ message: "There is an error in getting application" });
  }
}

export const deleteApplication = async (req: Request | any, res: Response) => {
  try {
    const application_id = req.params.id;
    console.log(application_id);
    const application = await models.Application.findByIdAndRemove(application_id);

    if(!application) {
      return res.status(404).json({ message: "Application with such id is not found" });
    }
    res.status(200).json(application)
  } catch(error) {
    console.log(error);
  }
}

