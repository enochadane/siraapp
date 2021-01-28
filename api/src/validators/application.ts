import { check } from "express-validator";

export const applicantFormValidator = [
  /***
     *  applicant_id,
      job_id,
      other_info,
      company_id,
     */
  check("applicant_id")
    .notEmpty()
    .withMessage("applicant id must not be empty"),
  check("job_id").notEmpty().withMessage("job id must not be empty"),
  check("company_id").notEmpty().withMessage("company id must not be empty"),
  check("other info").notEmpty().withMessage("Some message must be written"),
];
