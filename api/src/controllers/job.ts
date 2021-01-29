import job, { IJob, JobTypes } from "../models/job";
import { Request, Response } from "express";
import Job from "../models/job";
import models from "../models";
import querystring from "query-string";
/* 
 name: String;
 description: String;
 date_published: String;
 job_category_id: String;
 job_type: String;
 job_position: String;
 company_id: String;
 other_info: String;
 experience_level: String;
 deadline: String;
 */

export const createJob = async (req: Request | any, res: Response) => {
  const {
    name,
    description,
    date_published,
    job_category_id,
    job_type,
    other_info,
    experience_level,
    deadline,
    job_position,
  } = req.body;
  let selectedJobType;

  switch (job_type) {
    case "contract":
      selectedJobType = JobTypes.CONTRACT;
      break;
    case "internship":
      selectedJobType = JobTypes.INTERNSHIP;
      break;
    default:
      selectedJobType = JobTypes.CONTRACT;
      break;
  }
  try {
    const newJob = new models.Job();
    newJob.name = name;
    newJob.description = description;
    newJob.date_published = date_published;
    newJob.job_category_id = job_category_id;
    newJob.job_type = selectedJobType;
    newJob.other_info = other_info;
    newJob.experience_level = experience_level;
    newJob.deadline = deadline;
    newJob.job_position = job_position;
    newJob.company_id = req.profile._id;
    const job = await newJob.save();
    if (job) {
      res.status(201).json({ message: "Job has been created successfuly" });
    } else {
      res.status(403).json({ message: "There is an error on creating job" });
    }
  } catch (error) {
    res
      .status(500)
      .json({ message: "Something went wrong on creating job " + error });
  }
};

export const getJob = async (req: Request, res: Response) => {
  const job_id = req.params.id;
  try {
    models.Job.findById(job_id).exec((err, job) => {
      if (err || !job) {
        return res
          .status(404)
          .json({ message: "There is not job with a specified id" });
      }
      return res.status(200).json(job);
    });
  } catch (error) {
    return res
      .status(404)
      .json({ message: "There is an error on getting job" });
  }
};

export const getJobs = async (req: Request, res: Response) => {
  try {
    models.Job.find().exec((err, jobs) => {
      if (err || !jobs) {
        return res
          .status(404)
          .json({ message: "There is not jobs with a specified id" });
      }
      return res.status(200).json(jobs);
    });
  } catch (error) {
    return res
      .status(404)
      .json({ message: "There is an error on getting jobs" });
  }
};

export const getJobsWithCategory = async (req: Request, res: Response) => {
  const job_category_id = req.params.cetegory.toLowerCase();
  try {
    models.Job.find({ job_category_id }).exec((err, jobs) => {
      if (err || !jobs) {
        return res
          .status(404)
          .json({ message: "Job with a specified category is not found" });
      }
      res.status(200).json(jobs);
    });
  } catch (error) {
    return res
      .status(404)
      .json({ message: "There is an error on getting jobs" });
  }
};

export const updateJob = async (req: Request | any, res: Response) => {
  const {
    name,
    description,
    date_published,
    job_category_id,
    job_type,
    other_info,
    experience_level,
    deadline,
    job_position,
  } = req.body;

  try {
    const job_id = req.params.id;
    const existedjob: IJob | null = await models.Job.findById(job_id);
    const job_company_id = existedjob?.company_id;
    if (job_company_id?.toString() !== req.profile._id.toString()) {
      return res.status(403).json({ message: "UnAuthorized Action" });
    }

    const job = await models.Job.findByIdAndUpdate(job_id, {
      name,
      description,
      date_published,
      job_category_id,
      job_type,
      other_info,
      experience_level,
      deadline,
      job_position,
    });
    if (!job) {
      return res
        .status(403)
        .json({ message: "There is an error on updating job" });
    }
    return res.status(201).json(job);
  } catch (error) {
    return res
      .status(404)
      .json({ message: "There is an error on getting jobs" });
  }
};

export const deleteJob = async (req: Request | any, res: Response) => {
  try {
    const job_id = req.params.id;
    const existedjob: IJob | null = await models.Job.findById(job_id);
    const job_company_id = existedjob?.company_id;
    if (job_company_id !== req.profile._id) {
      return res.status(403).json({ message: "UnAuthorized Process" });
    }

    const job = await models.Job.findByIdAndRemove(job_id);
    if (!job) {
      return res
        .status(404)
        .json({ message: "Job with a specified category is not found" });
    }
    res.status(200).json(job);
  } catch (error) {}
};

export const getJobBySearch = async (req: Request, res: Response) => {
  const query: any = {};
  if (req.query.search_query) {
    const searchQuery =
      req.query.search_query?.toString().toLowerCase().trim() || "all";
    query.name = { $regex: searchQuery, $options: "i" };
    if (req.query.job_category && req.query.job_category !== "all") {
      query.job_category = { $regex: req.query.job_category, $options: "i" };
    }
    models.Job.find(query).exec((err, jobs) => {
      if (err || !jobs) {
        return res.status(400).json({
          message: "No Result",
        });
      }
      // const jobresults = [...jobresults.forEach(job => job.photo = undefined)]
      return res.json(jobs);
    });
  }
};
