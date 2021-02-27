import express from "express";
import {
  createCategory,
  deleteCategory,
  getCategories,
  getCategory,
  getJobsWithCategory,
  updateCategory,
} from "../controllers/job_category";
import { requireSignIn } from "../middlewares/auth";
import { JobCategoryFormValidator } from "../validators/job_category";

const router = express.Router();

router.get("/", getCategories);
router.get("/:id/jobs", requireSignIn, getJobsWithCategory);
router.get("/:id", getCategory);
router.post("/", JobCategoryFormValidator, requireSignIn, createCategory);
router.delete("/:id", requireSignIn, deleteCategory);
router.put("/:id", JobCategoryFormValidator,requireSignIn, updateCategory);


// router.get("/", getCategories);
// router.get("/:id/jobs", getJobsWithCategory);
// router.get("/:id", getCategory);
// router.post("/", JobCategoryFormValidator, createCategory);
// router.delete("/:id", deleteCategory);
// router.put("/:id", JobCategoryFormValidator, updateCategory);

export default router;
