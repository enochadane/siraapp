import { Request, Response } from "express";
import models from "../models";
import { IRole } from "../models/role";

export const getRoles = async (req: Request, res: Response) =>{
    try {
        models.Role.find().exec((err, roles) => {
          if (err || !roles) {
            return res
              .status(404)
              .json({ message: "There is not role with a specified id" });
          }
          return res.status(200).json(roles);
        });
      } catch (error) {
        return res
          .status(404)
          .json({ message: "There is an error on getting roles" });
      }
}

export const createRole = async (req: Request, res: Response) =>{
    const { name } = req.body;
    try {
      const role: IRole = await models.Role.create({
        name,
      });
      if (!role) {
        console.log('role creation failed')
        return res
          .status(403)
          .json({ message: "There is an error on creating role" });
      }
      return res.status(200).json(role);
    } catch (error) {
      console.log(`${error} error is `)
      return res
        .status(404)
        .json({ message: "There is an error on creating role" });
    }
}

export const updateRole = async (req: Request, res: Response) =>{
    const role_id = req.params.id;
    const { name } = req.body;
    try {
      let role = await models.Role.findById(role_id);
      if (!role) {
        return res
          .status(403)
          .json({ message: "There is an error on creating role" });
      }
      role.name = name;
      role = await role.save();

      return res.status(201).json(role);

    } catch (error) {
      return res
        .status(404)
        .json({ message: "There is an error on getting role" });
    }
}

export const deleteRole = async (req: Request, res: Response) =>{
    const role_id = req.params.id;
    try {
      models.Role.findByIdAndDelete(role_id).exec((err, role) => {
        if (err || !role) {
          return res
            .status(403)
            .json({ message: "There is no role with specified role" });
        }
        return res.status(201).json(role);
      });
    } catch (error) {
      return res
        .status(404)
        .json({ message: "There is an error on delete Roles" });
    }
}