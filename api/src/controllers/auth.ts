import { NativeError } from "mongoose";
import models from "../models";
import { IUser } from "../models/user";
import Jwt from "jsonwebtoken"

export const signUp = async (req: any, res: any) => {
  const username = req.body.username;
  const email = req.body.email;
  const password = req.body.password;
  const confirm_password = req.body.confirm_password;
  const role_id = req.body.role_id;

  if (confirm_password !== password) {
    return res.json({ message: "Password are not the same" });
  }

  try {
    await models.User.findOne({ email }).exec(
      async (_err: NativeError, existing_user) => {
        if (existing_user) {
          return res
            .status(400)
            .json({ error: "User exists with a given email" });
        }

        const user:IUser = await models.User.create({
          username,
          email,
          password,
          role_id: role_id,
        });
        models.Role.findById(role_id).exec((err, role) => {
          if (err || !role) {
          } else {
            if (role?.name === "SEEKER") {
              profile = models.SeekerProfile.create({
                user_id: user._id,
              });
            }
            else if (role?.name === "EMPLOYER") {
              profile = models.CompanyProfile.create({
                user_id: user._id,
              });
            }
          }
        });
        let profile;
       
        if (profile) {
          return res.json({ message: "Signup success, please sign in" });
        } else {
          return res
            .status(400)
            .json({ error: "There is something wrong on creating a user" });
        }
      }
    );
  } catch (error) {
    console.log(error);
    return res
      .status(400)
      .json({ error: "There is something wrong on creating a user" });
  }
};

export const signIn = async (req: any, res: any) => {
  const email = req.body.email;
  const password = req.body.password;
  if (!email || !password) {
    return res.json({ message: "All Fields are required!" });
  }
  const secret = process.env.JWT_SECRET || "sample secret";

  try {
    console.log("the password is Password", password);
    models.User.findOne({ email }).exec(async (_err, user: IUser | null) => {
      console.log("user is ", user);
      if (!user) {
        return res.status(400).json({ error: "User doesn't exist" });
      }

      const isMatched = await user.authenticate(password);
      if (!isMatched) {
        return res.status(400).json({ error: "INVALID email or password" });
      }
        const token = Jwt.sign(
          {
            _id: user._id,
            username: user.username,
            email: user.email,
          },
          secret,
          { expiresIn: "10d" }
        );
      return res
        .status(200)
        .json({ token, user: { username: user.username, email } });
    });
  } catch (error) {
    console.log(error);
    return res
      .status(400)
      .json({ error: "There is something wrong on creating a user" });
  }
};

export const signOut = (_req: any, res: any) => {
  res.clearCookie("token");
  res.json({
    message: "Signout Success",
  });
};
