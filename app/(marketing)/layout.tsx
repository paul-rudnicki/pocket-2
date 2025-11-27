export default function RootLayout({
    children,
}: Readonly<{
    children: React.ReactNode
}>) {
    return (
        <div>
            <header>Header Menu</header>
            <main>{children}</main>
        </div>
    )
}
