///
/**
 * id 
 * date of application 
 * education 
 * experience 
 * other info 
 * jobs_id 
 * applicant_id(seeker_id)
 */

 import mongoose, {Document, Schema} from "mongoose"
import { ISeekerProfile } from "./seeker_profile"

export interface IApplication extends Document{
    job_id : String, 
    applicant_id: String, 
    company_id: String,
    other_info: String, 
    applicant_profile: ISeekerProfile,
    applicant: any,
}

 const applicationSchema:Schema<IApplication>  = new mongoose.Schema({
    job_id: {
        type: mongoose.Types.ObjectId,
        ref: "Job"
    }, 
    applicant_id: {
        type: mongoose.Types.ObjectId, 
        ref: "User"
    }, 
    company_id: {
        type: mongoose.Types.ObjectId, 
        ref: "User"
    }, 
    other_info: String
 }, {timestamps: true})


 export default mongoose.model("Application", applicationSchema)