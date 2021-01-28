import { check } from "express-validator";

export const companyProfileFormValidator = [
  check("display_name")
    .notEmpty()
    .withMessage("display_name must not be empty"),
  check("location").notEmpty().withMessage("location must not be empty"),
  check("phone_number")
    .notEmpty()
    .withMessage("phone_number must not be empty"),
  check("company_website")
    .notEmpty()
    .withMessage("company_website must not be empty"),
  check("summary").notEmpty().withMessage("summary must not be empty"),
  check("eastablishment_date")
    .notEmpty()
    .withMessage("eastablishment_date must not be empty"),
];
