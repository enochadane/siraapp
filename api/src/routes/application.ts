import express from "express"
import { applyForJob, getApplication, getApplicationsWithJobId, getApplicationsWithApplicantId, updateApplication, deleteApplication } from "../controllers/application"
import { requireSignIn } from "../middlewares/auth"
import { runValidation } from "../validators"
import {applicantFormValidator} from "../validators/application";
const router = express.Router()

router.post("/", applicantFormValidator,requireSignIn, applyForJob)
router.get("/job/:job_id", getApplicationsWithJobId)
router.get("/user/:applicant_id", getApplicationsWithApplicantId)
router.get("/:id", getApplication)
router.patch("/:id", applicantFormValidator, requireSignIn, updateApplication)
router.delete("/:id", deleteApplication)

export default router