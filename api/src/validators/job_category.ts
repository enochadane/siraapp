import { check } from "express-validator";

export const JobCategoryFormValidator = [
  /***
     *  applicant_id,
      job_id,
      other_info,
      company_id,
     */

  check("name").notEmpty().withMessage("name must not be empty"),
  check("description").notEmpty().withMessage("description must not be empty"),
];
