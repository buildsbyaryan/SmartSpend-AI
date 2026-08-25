const express = require("express");
const cors = require("cors");

const authRoutes = require("./routes/authRoutes");
const expenseRoutes = require("./routes/expenseRoutes");
const incomeRoutes = require("./routes/incomeRoutes");
const errorHandler = require("./middleware/errorMiddleware");
const profileRoutes = require("./routes/profileRoutes");
const analyticsRoutes = require("./routes/analyticsRoutes");
const balanceRoutes = require("./routes/balanceRoutes");
const insightRoutes =
require("./routes/insightRoutes");
const notificationRoutes =
require("./routes/notificationRoutes");
const reportRoutes =
require("./routes/reportRoutes");
const budgetRoutes =
require("./routes/budgetRoutes");
const dashboardRoutes =
require("./routes/dashboardRoutes");

const app = express();

app.use(cors());
app.use(express.json());
app.use(
"/api/expenses",
expenseRoutes
);
app.use(
"/api/analytics",
analyticsRoutes
);
app.use(
"/api/profile",
profileRoutes
);

// Routes
app.use("/api/auth", authRoutes);
app.use("/api/expenses", expenseRoutes);
app.use("/api/income", incomeRoutes);
app.use(
"/api/balance",
balanceRoutes
);
app.use(
"/api/insights",
insightRoutes
);
app.use(
"/api/notifications",
notificationRoutes
);
app.use(
"/api/reports",
reportRoutes
);

app.use(
"/api/budgets",
budgetRoutes
);

app.use(
"/api/dashboard",
dashboardRoutes
);


app.get("/", (req, res) => {
  res.json({
    success: true,
    message: "SmartSpend AI Backend Running",
  });
});

// Error middleware ALWAYS LAST
app.use(errorHandler);

module.exports = app;