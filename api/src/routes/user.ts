import express from "express";
import {
  deleteCompanyProfile,
  getCompanyProfile,
  updateCompanyProfile,
} from "../controllers/company_profile";
import {
  deleteSeekerProfile,
  getSeekerProfile,
  updateSeekerProfile,
} from "../controllers/seeker_profile";
import { getUserProfile } from "../controllers/user";
import { requireSignIn } from "../middlewares/auth";
const router = express.Router();

router.get("/:username/profile", getUserProfile);
router.put("/:id/seeker", requireSignIn, updateSeekerProfile);
router.put("/:id/company", requireSignIn, updateCompanyProfile);
router.get("/:id/seeker", requireSignIn, getSeekerProfile);
router.get("/:id/company", getCompanyProfile);
router.get("/:id/seeker", deleteSeekerProfile);
router.get("/:id/company", deleteCompanyProfile);

export default router;
