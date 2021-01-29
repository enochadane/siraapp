import { Request } from "express";
import multer from "multer";
import slugify from "slugify";

export const requireMulterCvUpload = multer({
  storage: multer.diskStorage({
    filename: (_req:Request|any, file, cb) => {
        const file_extn = file.mimetype.substring(6);
        const filename =
          file.originalname
            .toString()
            .substring(0, file.originalname.lastIndexOf(".")) + "-";
            cb(null, slugify(_req?.user?.username)+ "-" + slugify(filename) + Date.now() + `.${file_extn}`);
      },
      destination: "public/uploads/resume/",
    }),
  });
  

  export const requireMulterProfileUpload = multer({
    storage: multer.diskStorage({
      filename: (_req:Request|any, file, cb) => {
          const file_extn = file.mimetype.substring(6);
          const filename =
            file.originalname
              .toString()
              .substring(0, file.originalname.lastIndexOf(".")) + "-";
              cb(null, slugify(_req?.user?.username)+ "-" + slugify(filename) + Date.now() + `.${file_extn}`);
        },
        destination: "public/uploads/profile/",
      }),
    });
    