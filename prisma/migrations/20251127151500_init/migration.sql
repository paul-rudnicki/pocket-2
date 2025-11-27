/*
  Warnings:

  - The primary key for the `User` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the `Post` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[id]` on the table `User` will be added. If there are existing duplicate values, this will fail.
  - Made the column `name` on table `User` required. This step will fail if there are existing NULL values in that column.

*/
-- CreateEnum
CREATE TYPE "SUBSCRIPTION_CURRENCY" AS ENUM ('PLN', 'EUR', 'USD');

-- CreateEnum
CREATE TYPE "SUBSCRIPTION_BILLING_PERIOD" AS ENUM ('MONTHLY', 'QUARTERLY', 'YEARLY');

-- CreateEnum
CREATE TYPE "SUBSCRIPTION_STATUS" AS ENUM ('ACTIVE', 'NOT_ACTIVE');

-- CreateEnum
CREATE TYPE "PAYMENT_STATUS" AS ENUM ('NOT_PAID', 'PAID');

-- DropForeignKey
ALTER TABLE "Post" DROP CONSTRAINT "Post_authorId_fkey";

-- AlterTable
ALTER TABLE "User" DROP CONSTRAINT "User_pkey",
ALTER COLUMN "name" SET NOT NULL,
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ADD CONSTRAINT "User_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "User_id_seq";

-- DropTable
DROP TABLE "Post";

-- CreateTable
CREATE TABLE "Subscription" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "currency" "SUBSCRIPTION_CURRENCY" NOT NULL DEFAULT 'PLN',
    "start_date" DATE NOT NULL,
    "end_date" DATE,
    "billing_period" "SUBSCRIPTION_BILLING_PERIOD" NOT NULL DEFAULT 'MONTHLY',
    "next_payment_date" DATE NOT NULL,
    "category" TEXT NOT NULL,
    "avatar_url" TEXT NOT NULL,
    "status" "SUBSCRIPTION_STATUS" NOT NULL DEFAULT 'ACTIVE',
    "ownerId" TEXT NOT NULL,

    CONSTRAINT "Subscription_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Payment" (
    "id" TEXT NOT NULL,
    "amount" DOUBLE PRECISION NOT NULL,
    "due_date" DATE NOT NULL,
    "status" "PAYMENT_STATUS" NOT NULL DEFAULT 'NOT_PAID',
    "subscriptionId" TEXT NOT NULL,

    CONSTRAINT "Payment_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_id_key" ON "User"("id");

-- AddForeignKey
ALTER TABLE "Subscription" ADD CONSTRAINT "Subscription_ownerId_fkey" FOREIGN KEY ("ownerId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Payment" ADD CONSTRAINT "Payment_subscriptionId_fkey" FOREIGN KEY ("subscriptionId") REFERENCES "Subscription"("id") ON DELETE CASCADE ON UPDATE CASCADE;
