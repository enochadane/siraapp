import express from "express";

import {
  createJob,
  getJobs,
  getJob,
  deleteJob,
  getJobsWithCategory,
  updateJob,
  getJobBySearch,
  getJobsByCompanyId
} from "../controllers/job";
import { authMiddleware, requireSignIn } from "../middlewares/auth";
import { jobFormValidator } from "../validators/job";
const router = express.Router();

router.post("/", jobFormValidator, requireSignIn, authMiddleware, createJob);
router.get("/", getJobs);
router.get("/search", getJobBySearch);
router.get("/:id", getJob);
router.put("/:id", jobFormValidator, requireSignIn, authMiddleware, updateJob);
router.delete("/:id", requireSignIn,authMiddleware, deleteJob);
router.get("/:category/jobs", getJobsWithCategory);
router.get("/company/:company_id", getJobsByCompanyId);


// router.post("/", jobFormValidator, createJob);
// router.get("/", getJobs);
// router.get("/search", getJobBySearch);
// router.get("/:id", getJob);
// router.put("/:id", jobFormValidator, updateJob);
// router.delete("/:id", deleteJob);
// router.get("/:category/jobs", getJobsWithCategory);

export default router;
