import mongoose, { Document, Schema } from "mongoose";

/**
 * id
 * firstname
 * lastname
 * email
 * phone
 * summary
 * resume_url
 */

export interface ISeekerProfile extends Document {
  user_id: String;
  firstname: String;
  lastname: String;
  phone_number: String;
  gender: String;
  summary: String;
  photo: String;
  certificate_degree_name: String;
  major: String;
  resume_url: String;
}

const seekerProfileSchema:Schema<ISeekerProfile> = new mongoose.Schema(
  {
    user_id: {
      type: mongoose.Types.ObjectId,
      ref: "User",
    },
    firstname: { type: String, default: "" },
    lastname: { type: String, default: "" },
    phone_number: { type: String, default: "" },
    gender: { type: String, default: "" },
    summary: { type: String, default: "" },
    photo: { type: String, default: "" },
    certificate_degree_name: { type: String, default: "" },
    major: { type: String, default: "" },
    resume_url: { type: String, default: "" },
  },
  { timestamps: true }
);

export default mongoose.model("Seeker", seekerProfileSchema);
