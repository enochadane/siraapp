import mongoose, { Schema, Document } from "mongoose";
import bcrypt from "bcryptjs";
import { IRole } from "./role";

export interface IUser extends Document {
  username: String;
  email: String;
  password: any;
  role_id: IRole;
  reset_password_link: String | null;
  authenticate: Function;
}
const userSchema: Schema<IUser> = new mongoose.Schema(
  {
    username: {
      type: String,
      required: true,
      maxlength: 32,
      unique: true,
      lowercase: true,
      index: true,
      trim: true,
    },
    email: {
      type: String,
      required: true,
      trim: true,
      unique: true,
      lowercase: true,
      maxlength: 50,
    },
    password: {
      type: String,
      required: true,
    },
    role_id: {
      type: String,
      ref: "Role",
      default: 0,
    },
    reset_password_link: {
      type: String,
      default: "",
    },
  },
  { timestamps: true }
);

userSchema.pre<IUser>("save", async function (next: Function) {
  if (this.password) {
    const salt = await bcrypt.genSalt(10);
    this.password = await bcrypt.hash(
      this.password.toString(),
      salt.toString()
    );
  }
  next();
});

userSchema.methods.authenticate = function (plainTextPassword: string) {
  return bcrypt.compareSync(plainTextPassword, this.password);
};

export default mongoose.model<IUser>("User", userSchema);
