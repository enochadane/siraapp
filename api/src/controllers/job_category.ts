import { Request, Response } from "express";
import models from "../models";
import { IJobCategory } from "../models/job_category";

export const getCategory = async (req: Request, res: Response) => {
  const category_id = req.params.id;
  try {
    models.JobCategory.findById(category_id).exec((err, category) => {
      if (err || !category) {
        return res
          .status(404)
          .json({ message: "There is not category with a specified id" });
      }
      return res.status(200).json(category);
    });
  } catch (error) {
    return res
      .status(404)
      .json({ message: "There is an error on getting category" });
  }
};

export const getCategories = async (req: Request, res: Response) => {
  try {
    models.JobCategory.find().exec((err, categories) => {
      if (err || !categories) {
        return res
          .status(404)
          .json({ message: "There is not category with a specified id" });
      }
      return res.status(200).json(categories);
    });
  } catch (error) {
    return res
      .status(404)
      .json({ message: "There is an error on getting categories" });
  }
};

export const createCategory = async (req: Request, res: Response) => {
  const { name, description } = req.body;
  try {
    const category: IJobCategory = await models.JobCategory.create({
      name,
      description,
    });
    if (!category) {
      return res
        .status(403)
        .json({ message: "There is an error on creating category" });
    }
    return res.status(200).json(category);
  } catch (error) {
    return res
      .status(404)
      .json({ message: "There is an error on getting categories" });
  }
};

export const updateCategory = async (req: Request, res: Response) => {
  const category_id = req.params.id;
  const { name, description } = req.body;
  try {
    let category = await models.JobCategory.findById(category_id);
    if (!category) {
      return res
        .status(403)
        .json({ message: "There is an error on creating category" });
    }
    category.name = name;
    category.description = description;

    category = await category.save();
    return res.status(201).json(category);
  } catch (error) {
    return res
      .status(404)
      .json({ message: "There is an error on getting categories" });
  }
};

export const deleteCategory = async (req: Request, res: Response) => {
  const category_id = req.params.id;
  try {
    models.JobCategory.findByIdAndDelete(category_id).exec((err, category) => {
      if (err || !category) {
        return res
          .status(403)
          .json({ message: "There is no category with specified category" });
      }
      return res.status(201).json(category);
    });
  } catch (error) {
    return res
      .status(404)
      .json({ message: "There is an error on getting categories" });
  }
};

export const getJobsWithCategory = async (req: Request, res: Response) => {
    const job_category_id = req.params.id.toLowerCase();
    try {
      models.Job.find({ job_category_id }).exec((err, jobs) => {
        if (err || !jobs) {
          return res
            .status(404)
            .json({ message: "Job with a specified category is not found" });
        }
        res.status(200).json(jobs);
      });
    } catch (error) {}
  };