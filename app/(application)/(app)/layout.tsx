export default function RootLayout({
    children,
}: Readonly<{
    children: React.ReactNode
}>) {
    return (
        <div>
            <aside>Sidebar Menu</aside>
            <main>{children}</main>
        </div>
    )
}
