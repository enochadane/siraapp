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
import { changeUserRole, deleteUser, getUser, getUserProfile, getUsers, updateUser } from "../controllers/user";
import { adminMiddleware, authMiddleware, requireSignIn } from "../middlewares/auth";
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
router.put(":id/changerole", requireSignIn, authMiddleware, adminMiddleware, changeUserRole)
router.put(":id", requireSignIn, authMiddleware, updateUser)
router.delete(":id", requireSignIn, authMiddleware, deleteUser)
router.get("/", getUsers)
router.get("/:id", requireSignIn, getUser)
export default router;
