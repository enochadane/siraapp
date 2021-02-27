import {Request, Response} from "express"
import Jwt from "jsonwebtoken"
import models from "../models";


export const requireSignIn = (req: Request|any, res: Response, next: Function) => {
  const secret = process.env.JWT_SECRET || "secret"
  try {
    const token = req.headers.authorization?.split(" ")[1] || "sample";
    const decoded = Jwt.verify(token, secret);
    req.user = decoded;
    next();
  } catch (err) {
    res.status(403).json({ message: "UnAuthenicated Access" });
  }
};

export const authMiddleware = (req: any, res: Response, next: Function) => {
  const authUserId = req.user._id;
  models.User.findById(authUserId).exec((err, user) => {
    if (err && !user) {
      return res.status(400).json({
        error: "User not found",
      });
    }
    req.profile = user;
    next();
  });
};


export const adminMiddleware = (req: any, res: Response, next: Function) => {
  // const role = req.profile.role;

  // if(role === "ADMIN"){
    next();
  // }else{
    // res.status(403).json({message: "UnAuthorized"})
  // }
};
