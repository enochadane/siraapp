import express from "express"; 
import morgan from "morgan";
import cors from "cors";
import path from "path";
import dotenv from "dotenv";
import mongoose from "mongoose"
import routes from "./routes"

const app = express()
app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.use(cors());

app.use(morgan("dev"));
dotenv.config();

const path_name: string = path.join(__dirname, "./public");
console.log(path_name);
app.use(express.static(path_name));
const PORT = process.env.PORT || 8383;
const DATABASE_URI =  process.env.DATABASE_URI || "mongodb://localhost:27017/sira_app";


app.use("/api", routes.authRoutes)
app.use("/api/users", routes.userRoutes)
app.use("/api/roles", routes.roleRoutes)
app.use("/api/jobs", routes.jobRoutes)
app.use("/api/apply", routes.jobApplyRoutes)
app.use("/api/categories", routes.jobCategoryRoutes)
app.use("/", (_req, res)=> res.json({message: "The API is working"}))

mongoose
  .connect(DATABASE_URI, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
    useCreateIndex: true,
    useFindAndModify: false,
  })
  .then(() => {
    app.listen(PORT, () =>
      console.log(`Server is running... http://localhost:${PORT}`)
    );
  })
  .catch((err) => console.log("There is an error on connecting", err));
