

import mongoose, { Document, Schema } from "mongoose";

export interface IRole extends Document {
  name: String;
}

const roleSchema:Schema<IRole> = new mongoose.Schema(
  {
    name: {
        type: String, 
        unique: true, 
        maxlength: 20
    },
  },
  { timestamps: true }
);

export default mongoose.model("Role", roleSchema)