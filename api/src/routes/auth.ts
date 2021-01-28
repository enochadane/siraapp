import express from "express";
import { signIn, signUp } from "../controllers/auth";
import { runValidation } from "../validators";
import { userSignInValidator, userSignUpValidator } from "../validators/auth";

const router = express.Router();

router.post("/signin", userSignInValidator, runValidation, signIn);
router.post("/signup", userSignUpValidator, runValidation, signUp);

export default router;
