import { check } from "express-validator";

export const userSignUpValidator = [
  check("password")
    .matches(check("confirm_password").toString())
    .withMessage("password is not the same"),
  check("username")
    .isLength({ min: 3 })
    .withMessage("Name Must be at least 3 length character"),
  check("email").isEmail().withMessage("Must be a valid email addresss"),
  check("password")
    .isLength({ min: 6 })
    .withMessage("Password Must be at least six length character"),
];

export const userSignInValidator = [
  check("email").isEmail().withMessage("Must be a valid email addresss"),
  check("password")
    .isLength({ min: 6 })
    .withMessage("Must be at lease six length character"),
];

export const forgotPasswordValidator = [
  check("email").isEmail().withMessage("Must be a valid email addresss"),
];

export const resetPasswordValidator = [
  check("password")
    .isLength({ min: 6 })
    .withMessage("Must be at lease six length character"),
];
