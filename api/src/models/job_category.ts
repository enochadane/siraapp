/**
 * job_category
 *
 * id
 * name
 * description
 */

import mongoose, { Document, Schema } from "mongoose";

export interface IJobCategory extends Document {
  name: String;
  description: String;
}

const jobCategorySchema:Schema<IJobCategory> = new mongoose.Schema(
  {
    name: String,
    description: String,
  },
  { timestamps: true }
);

export default mongoose.model("JobCategory", jobCategorySchema)