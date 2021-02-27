/**
 * id
 * name
 * description
 * date_published
 * job_category_Id
 * company_id
 *
 */

import mongoose, { Document, Schema } from "mongoose";

export interface IJob extends Document {
  name: String;
  description: String;
  job_position: String;
  experience_level: String;
  other_info: String;
  deadline: String;
  date_published: String;
  job_category_id: mongoose.Types.ObjectId;
  job_type: JobTypes;
  company_id: String;
}

export enum JobTypes {
  INTERNSHIP,
  CONTRACT,
}

const jobSchema: Schema<IJob> = new mongoose.Schema(
  {
    name: {
      type: String,
      required: true,
    },
    description: {
      type: String,
      required: true,
    },
    job_position: { type: String, default: "" },
    experience_level: { type: String, required: true },
    other_info: { type: String, default: "" },
    deadline: { type: Date, required: true },
    date_published: {
      type: Date,
      default: Date.now(),
    },
    job_type: {
      type: String,
      default: "CONTRACT",
    },
    job_category_id: {
      type: mongoose.Types.ObjectId,
      ref: "JobCategory",
    },
    company_id: {
      type: mongoose.Types.ObjectId,
      ref: "User",
    },
  },
  { timestamps: true }
);

export default mongoose.model("Job", jobSchema);
