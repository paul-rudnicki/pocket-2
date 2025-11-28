import {
    LoginLink,
    LogoutLink,
    RegisterLink,
} from "@kinde-oss/kinde-auth-nextjs/components"
import { buttonVariants } from "./ui/button"
import { getKindeServerSession } from "@kinde-oss/kinde-auth-nextjs/server"

export default async function AuthNavButtons() {
    const { getUser } = getKindeServerSession()
    const user = await getUser()
    return (
        <>
            {user ? (
                <LogoutLink className={buttonVariants()}>Log Out</LogoutLink>
            ) : (
                <>
                    <LoginLink className={buttonVariants()}>Sign In</LoginLink>
                    <RegisterLink
                        className={buttonVariants({ variant: "outline" })}
                    >
                        Sign up
                    </RegisterLink>
                </>
            )}
        </>
    )
}
