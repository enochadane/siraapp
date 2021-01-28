import { check } from "express-validator";

export const jobFormValidator = [
  check("name")
    .notEmpty()
    .withMessage("name must n't be empty")
    .isLength({ min: 5 })
    .withMessage("Name Must be at least 5 length character"),

  check("description")
    .notEmpty()
    .isLength({ min: 5 })
    .withMessage("Description Must be at least 50 length character"),

  check("job_category_id")
    .notEmpty()
    .withMessage("At least one Job category must be selected"),

  check("job_type")
    .notEmpty()
    .withMessage("job type must be selected selected"),
  check("experience_level")
    .notEmpty()
    .withMessage("experience level must be selected selected"),

  check("deadline").notEmpty().withMessage("Invalid date time"),
];
