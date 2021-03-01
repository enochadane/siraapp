import { NativeError } from "mongoose";
import models from "../models";
import { IUser } from "../models/user";
import Jwt from "jsonwebtoken"

export const signUp = async (req: any, res: any) => {
  const username = req.body.username;
  const email = req.body.email;
  const password = req.body.password;
  const role_id = req.body.role_id;

  try {
    await models.User.findOne({ email }).exec(
      async (_err: NativeError, existing_user) => {
        if (existing_user) {
          console.log("existing user")
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

        let profile;
        models.Role.findById(role_id).exec(async (err, role) => {
          console.log(user);
          console.log(role);
          if (err || !role) {
            console.log("there is an error", user)
            console.log("there is an error", err)
          } else {
            if (role?.name === "SEEKER") {
              profile = await models.SeekerProfile.create({
                user_id: user._id,
              });
            }
            else if (role?.name === "EMPLOYER") {
              profile = await models.CompanyProfile.create({
                user_id: user._id,
              });
            }
          }
        });
        
        // if (profile) {
          return res.status(201).json(user);
        // } else {
          // return res

            // .status(400)
            // .json({ error: "There is something wrong on creating a user" });
        // }
      }
    );
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ error: "There is something wrong on creating a user" });
  }
};

export const signIn = async (req: any, res: any) => {
  const email = req.body.email;
  const password = req.body.password;
  if (!email || !password) {
    return res.json({ message: "All Fields are required!" });
  }
  const secret = process.env.JWT_SECRET || "secret";

  try {
    models.User.findOne({ email }).populate("role_id", "_id name").exec(async (_err, user: IUser | null) => {
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
            role: user.role_id.name
          },
          secret,
          { expiresIn: "10d" }
        );
      return res
        .status(200)
        .json({ token, user: { id: user._id, username: user.username, email, role: user.role_id.name } });
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
