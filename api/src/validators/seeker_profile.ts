import { check } from "express-validator";

export const seekerFormValidator = [
  /***
    firstname: { type: String, default: "" },
    lastname: { type: String, default: "" },
    phone_number: { type: String, default: "" },
    gender: { type: String, default: "" },
    summary: { type: String, default: "" },
    photo: { type: String, default: "" },
    certificate_degree_name: { type: String, default: "" },
    major: { type: String, default: ""
     */

  check("firstname").notEmpty().withMessage("firstname must not be empty"),
  check("lastname").notEmpty().withMessage("lastname must not be empty"),
  check("phone_number").notEmpty().withMessage("phone_number must not be empty"),
  check("gender").notEmpty().withMessage("gender must not be empty"),
  check("summary").notEmpty().withMessage("summary must not be empty"),
  check("certificate_degree_name").notEmpty().withMessage("certificate_degree_name must not be empty"),
];
