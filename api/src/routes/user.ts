import express from "express";
import {
  deleteCompanyProfile,
  getCompanyProfile,
  updateCompanyProfile,
} from "../controllers/company_profile";
import {
  deleteSeekerProfile,
  getSeekerProfile,
  postResume,
  updateSeekerProfile,
} from "../controllers/seeker_profile";
import { getUserProfile } from "../controllers/user";
import { requireSignIn } from "../middlewares/auth";
import { requireMulterCvUpload, requireMulterProfileUpload } from "../middlewares/seeker";
const router = express.Router();

router.get("/:username/profile", getUserProfile);

router.put(
  "/seeker/:id/profile",
  requireSignIn,
  requireMulterProfileUpload.single("photo"),
  updateSeekerProfile
);

router.put("/post-resume", requireSignIn, requireMulterCvUpload.single("resume"), postResume)
router.put("/company/:id/profile", requireSignIn, updateCompanyProfile);
router.get("/seeker/:id/profile", requireSignIn, getSeekerProfile);
router.get("/company/:id", getCompanyProfile);
router.get("/seeker/:id", deleteSeekerProfile);
router.get("/company/:id", deleteCompanyProfile);

export default router;
