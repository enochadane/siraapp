import mongoose, { Schema, Document } from "mongoose";
import bcrypt from "bcryptjs";

export interface IUser extends Document {
  username: String;
  email: String;
  password: any;
  role: Roles | null;
  reset_password_link: String | null;
  authenticate: Function;
}

export enum Roles {
  SEEKER,
  EMPLOYER,
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
    role: {
      type: Roles,
      default: Roles.SEEKER,
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

// userSchema.

export default mongoose.model<IUser>("User", userSchema);
