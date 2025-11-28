import Image from "next/image"
import Link from "next/link"
import logo from "@/public/pocket.png"
import { buttonVariants } from "@/components/ui/button"
import {
    RegisterLink,
    LoginLink,
} from "@kinde-oss/kinde-auth-nextjs/components"
import AuthNavButtons from "@/components/AuthNavButtons"

export default function RootLayout({
    children,
}: Readonly<{
    children: React.ReactNode
}>) {
    return (
        <div>
            <header className="max-w-7xl mx-auto p-4  items-center gap-4 flex">
                <Link href="/" className="flex items-center gap-2">
                    <Image src={logo} alt="logo" width={25} height={25} />
                    <h1 className="font-bold text-lg">Portfel</h1>
                </Link>
                <nav className="w-full">
                    <ul className="flex items-center gap-2 justify-center">
                        <li>
                            <Link href="/blog">Blog</Link>
                        </li>
                        <li>
                            <Link href="/blog">Blog</Link>
                        </li>
                    </ul>
                </nav>
                <div className="flex items-center gap-2">
                    <AuthNavButtons />
                </div>
            </header>
            <main>{children}</main>
        </div>
    )
}
