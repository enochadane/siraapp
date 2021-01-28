import mongoose, { Document, Schema } from "mongoose";

/**
 * id
 * campany_id
 * display_name
 * phone_number
 * location
 * company_detail
 * company_website
 * eastablishment_date
 * company_image
 */

export interface ICompanyProfile extends Document {
  company_id: String;
  display_name: String;
  phone_number: String;
  location: String;
  company_detail: String;
  photo: String;
  company_website: String;
  eastablishment_date: String;
}

const companyProfileSchema:Schema<ICompanyProfile> = new mongoose.Schema(
  {
    user_id: {
      type: mongoose.Types.ObjectId,
      ref: "User",
    },
    display_name: { type: String, default: "" },
    phone_number: { type: String, default: "" },
    location: { type: String, default: "" },
    company_detail: { type: String, default: "" },
    photo: { type: String, default: "" },
    company_website: { type: String, default: "" },
    eastablishment_date: { type: String, default: "" },
  },
  { timestamps: true }
);

export default mongoose.model("CompanyProfile", companyProfileSchema);
