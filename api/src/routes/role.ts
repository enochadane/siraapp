import express from "express"
import { createRole, deleteRole, getRoles, updateRole } from "../controllers/role"
import { adminMiddleware, authMiddleware, requireSignIn } from "../middlewares/auth"

const router = express.Router()

router.get("/", getRoles)

router.post("/", requireSignIn, authMiddleware, adminMiddleware, createRole)

router.put("/:id", requireSignIn, authMiddleware, adminMiddleware, updateRole)

router.delete("/:id", deleteRole)

export default router