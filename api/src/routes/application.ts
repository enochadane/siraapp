import express from "express"
import { applyForJob, getApplication, getApplicationWithCompanyId, updateApplication, deleteApplication } from "../controllers/application"
import { requireSignIn } from "../middlewares/auth"
import { runValidation } from "../validators"
import {applicantFormValidator} from "../validators/application";
const router = express.Router()

router.post("/", applicantFormValidator,requireSignIn, applyForJob)
router.get("/company/:company_id", getApplicationWithCompanyId)
router.get("/:id", getApplication)
router.patch("/:id", applicantFormValidator, runValidation,requireSignIn, updateApplication)
router.delete("/:id", deleteApplication)

export default router