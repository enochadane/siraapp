import express from "express"; 
import morgan from "morgan";
import cors from "cors";
import path from "path";
import dotenv from "dotenv";
import mongoose from "mongoose"
import authRoutes from "./routes/auth"

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


app.use("/api", authRoutes)
app.use("/", (_req, res)=> res.json({message: "The API is working"}))

mongoose
  .connect(DATABASE_URI, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
    useCreateIndex: true,
  })
  .then(() => {
    app.listen(PORT, () =>
      console.log(`Server is running... http://localhost:${PORT}`)
    );
  })
  .catch((err) => console.log("There is an error on connecting", err));
