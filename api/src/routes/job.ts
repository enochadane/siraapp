import express from "express";

import {
  createJob,
  getJobs,
  getJob,
  deleteJob,
  getJobsWithCategory,
  updateJob,
} from "../controllers/job";
import { authMiddleware, requireSignIn } from "../middlewares/auth";
import { jobFormValidator } from "../validators/job";
const router = express.Router();

router.post("/", jobFormValidator, requireSignIn, authMiddleware, createJob);
router.get("/", getJobs);
router.get("/:id", getJob);
router.put("/:id", jobFormValidator, requireSignIn, authMiddleware, updateJob);
router.delete("/:id", requireSignIn, deleteJob);
router.get("/:category/jobs", getJobsWithCategory);

export default router;
