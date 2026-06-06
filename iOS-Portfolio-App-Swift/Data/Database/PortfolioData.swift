import Foundation

enum PortfolioData {
    static let websiteURL = url("https://hiretimsf.com")
    static let fallbackImageURL = url("https://hiretimsf.com/images/logo.png")

    static let profile = Profile(
        greeting: "Nice to meet you",
        name: "Tim Baz",
        title: "Design Engineer",
        email: "hiretimsf@gmail.com",
        socials: [
            SocialLink(id: "x", name: "X (Twitter)", url: url("https://x.com/hiretimsf"), systemImage: "bubble.left.and.bubble.right"),
            SocialLink(id: "github", name: "GitHub", url: url("https://github.com/hiretimsf"), systemImage: "chevron.left.forwardslash.chevron.right"),
            SocialLink(id: "linkedin", name: "LinkedIn", url: url("https://www.linkedin.com/in/hiretimsf/"), systemImage: "person.crop.square")
        ]
    )

    static let welcome = [
        WelcomePage(
            title: "Hello",
            subtitle: "I'm Tim,",
            text: "I am a Design Engineer based in the San Francisco Bay Area.",
            imageName: "Onboarding01"
        ),
        WelcomePage(
            title: "Background",
            subtitle: "Web and Mobile apps,",
            text: "I build web, Android, and iOS apps with Next.js, Kotlin, and Swift.",
            imageName: "Onboarding02"
        ),
        WelcomePage(
            title: "Passion",
            subtitle: "My portfolio",
            text: "I built this app to share my work.",
            imageName: "Onboarding03"
        )
    ]

    static let aboutSections = [
        AboutSection(
            title: "Introduction",
            content: "I am a Design Engineer with 5+ years of experience building web apps with Next.js, Tailwind CSS, and TypeScript, Android apps with Kotlin and Jetpack Compose, and iOS apps with Swift and SwiftUI.\n\nI currently live in the San Francisco Bay Area with my family. I am originally from Mongolia and studied Computer Science in Germany. I speak English, German, and Mongolian, and I also understand some Russian."
        ),
        AboutSection(
            title: "How I got started",
            content: "After college, I started with Android development using my Java and XML background. I published several apps on the Google Play Store, building with Java, Kotlin, XML, Material Design, and Jetpack components."
        ),
        AboutSection(
            title: "Web Development",
            content: "I started learning Next.js and Tailwind CSS in late 2022 while working full-time at a factory. It was difficult to balance both, so I quit my job and moved to Mongolia for a lower cost of living. I spent three focused months there learning Next.js, React, TypeScript, and Tailwind CSS.\n\nDuring that time, I met my wife. We got married, our daughter was born, and we came back to the U.S. in late 2023. I kept learning and building side projects, including portfolio apps. One of my projects now has 460+ stars on GitHub, and another was mentioned on WeAreDevelopers.com."
        ),
        AboutSection(
            title: "Today",
            content: "In 2026, I completed my first paid client project with Next.js, React, TypeScript, and Tailwind CSS: a restaurant website with client login and a booking system. You can visit the live site at choijin.mn.\n\nI am currently building my first SaaS product, Menu.ceo, an online restaurant menu platform.\n\nTo learn more, visit my experience and education pages."
        )
    ]

    static let aboutPhotos = [
        AboutPhoto(url: url("https://hiretimsf.com/images/about/about_me_01.webp"), alt: "Tim's wedding photo showing a special moment with his wife"),
        AboutPhoto(url: url("https://hiretimsf.com/images/about/about_me_02.webp"), alt: "Tim with his family in a warm family moment"),
        AboutPhoto(url: url("https://hiretimsf.com/images/about/about_me_03.webp"), alt: "Tim running, showing his active lifestyle and fitness")
    ]

    static let aboutContent = AboutContent(sections: aboutSections, photos: aboutPhotos)

    static let projects = [
        Project(
            id: "ayalal-expo-2026",
            title: "Ayalal Expo 2026",
            subtitle: "Ayalal Expo 2026",
            header: "Next.js",
            coverImage: url("https://hiretimsf.com/images/projects/web/ayalal-expo/cover.webp"),
            logo: nil,
            imageDescription: "Ayalal Expo 2026 website cover",
            info: "Next.js 16, Tailwind CSS 4, shadcn/ui, Resend, Figma",
            text: "A client website for Ayalal Expo 2026, an outdoor and camping exhibition. I designed the first user flow in Figma, built the site with Next.js 16 and Tailwind CSS 4, used shadcn/ui for interface pieces, and connected contact flows with Resend.",
            start: "May 2026",
            end: "Jun 2026",
            links: [
                ProjectLink(title: "Website", url: url("https://ayalalexpo.mn")),
                ProjectLink(title: "PDF", url: url("https://ayalalexpo.mn/asset/taniltsuulga.pdf"))
            ]
        ),
        Project(
            id: "choijin-temple-restaurant",
            title: "Choijin Temple Restaurant",
            subtitle: "Choijin Temple Restaurant",
            header: "Next.js",
            coverImage: url("https://hiretimsf.com/images/projects/web/choijin-temple-restaurant/home-locations.webp"),
            logo: nil,
            imageDescription: "Screenshot of Choijin Temple Restaurant website",
            info: "Next.js, TypeScript, Tailwind CSS, Supabase, Codex",
            text: "A restaurant website for Choijin Temple with location pages, menu browsing, online table booking, and customer login. The site helps guests explore the restaurant, review menu categories, book a table online, and access customer flows from desktop and mobile.",
            start: "May 2026",
            end: "May 2026",
            links: [
                ProjectLink(title: "Website", url: url("https://choijin.mn"))
            ]
        ),
        Project(
            id: "menu-ceo",
            title: "Menu.ceo",
            subtitle: "Menu.ceo",
            header: "Next.js",
            coverImage: url("https://hiretimsf.com/images/projects/web/menu-ceo/home.webp"),
            logo: nil,
            imageDescription: "Screenshot of Menu.ceo",
            info: "Next.js, TypeScript, Tailwind CSS, Supabase, Codex",
            text: "My first SaaS product for restaurants that need a simple way to publish and manage menus online. Menu.ceo is designed around one menu that can work across websites, mobile views, short links, printable formats, custom domains, and AI-assisted setup.",
            start: "May 2026",
            end: "Active",
            links: [
                ProjectLink(title: "Website", url: url("https://menu.ceo"))
            ]
        ),
        Project(
            id: "full-stack-blog-app",
            title: "Full-Stack Blog App",
            subtitle: "Full-Stack Blog App",
            header: "Next.js",
            coverImage: url("https://hiretimsf.com/images/projects/web/blog-app.webp"),
            logo: nil,
            imageDescription: "Screenshot of Full Stack Blog App",
            info: "Next.js, TypeScript, Tailwind CSS, Supabase",
            text: "A responsive full-stack blog app built with Next.js, TypeScript, Tailwind CSS, and Supabase. The open-source project earned 460+ GitHub stars and recognition from Vercel.",
            start: "Jun 2023",
            end: "Oct 2023",
            links: [
                ProjectLink(title: "Website", url: url("https://ubdotcafe.vercel.app")),
                ProjectLink(title: "GitHub", url: url("https://github.com/timtbdev/Next.js-Blog-App"))
            ]
        ),
        Project(
            id: "portfolio-app-kotlin",
            title: "Portfolio App (Kotlin)",
            subtitle: "Portfolio App (Kotlin)",
            header: "Android",
            coverImage: url("https://hiretimsf.com/images/projects/android/portfolio-app-kotlin.webp"),
            logo: nil,
            imageDescription: "Portfolio App (Kotlin)",
            info: "Kotlin, Jetpack Compose, Material 3, Hilt, Room, DataStore, Retrofit",
            text: "A rebuilt Android portfolio app using Kotlin, Jetpack Compose, Material 3, Hilt, Room, DataStore, Retrofit, and Coroutines. It modernizes the older XML app while keeping the project focused on mobile architecture and clean UI.",
            start: "Apr 2017",
            end: "May 2026",
            links: [
                ProjectLink(title: "Play Store", url: url("https://play.google.com/store/apps/details?id=hiretimsf.com.app")),
                ProjectLink(title: "GitHub", url: url("https://github.com/timtbdev/Android-Portfolio-App-Kotlin"))
            ]
        )
    ]

    static let blogPosts = [
        BlogPost(
            slug: "rebuilding-android-portfolio-app-jetpack-compose",
            title: "I Rebuilt My Kotlin XML Portfolio App with Jetpack Compose",
            date: "May 26, 2026",
            category: "Android",
            readTime: "6 min read",
            excerpt: "I converted my old Kotlin XML Android portfolio app into a modern Jetpack Compose app with Material 3, Hilt, DataStore, Navigation, Coil, Retrofit, and a full visual refresh.",
            coverImageUrl: url("https://hiretimsf.com/images/blog/android-compose-portfolio-app/cover.webp"),
            imageAlt: "HireTimSF Android portfolio app cover showing Tim Baz and completed checklist items",
            url: url("https://hiretimsf.com/blog/rebuilding-android-portfolio-app-jetpack-compose"),
            sections: [
                BlogPostSection(title: "The rebuild", content: "The project started as a Kotlin XML portfolio app and was rebuilt with Jetpack Compose, Material 3, Hilt, DataStore, Navigation, Coil, Retrofit, and Coroutines."),
                BlogPostSection(title: "Why it matters", content: "Rebuilding the app made the code easier to maintain, easier to extend, and closer to how I would build an Android app today.")
            ],
            content: "",
            author: "Tim Baz",
            authorAvatarUrl: URL(string: "https://hiretimsf.com/images/logo.png"),
            tags: ["Android", "Kotlin", "Jetpack Compose", "Portfolio"]
        ),
        BlogPost(
            slug: "my-open-source-contribution",
            title: "How My Open Source Next.js App Got 460+ GitHub Stars and Vercel Recognition",
            date: "June 8, 2024",
            category: "Open Source",
            readTime: "4 min read",
            excerpt: "I built an open-source full-stack Next.js and Supabase blog app that earned 460+ GitHub stars and official recognition from Vercel's Lee Robinson.",
            coverImageUrl: url("https://hiretimsf.com/images/blog/my-open-source-contribution/cover.webp"),
            imageAlt: "Next.js open source blog app with GitHub stars and Vercel recognition",
            url: url("https://hiretimsf.com/blog/my-open-source-contribution"),
            sections: [
                BlogPostSection(title: "Project", content: "The project is a multi-user blog platform with auth, database, storage, and CMS features built with TypeScript and modern Next.js."),
                BlogPostSection(title: "Recognition", content: "The project was shared with the Vercel community and later received recognition that motivated me to keep building open-source work.")
            ],
            content: "",
            author: "Tim Baz",
            authorAvatarUrl: URL(string: "https://hiretimsf.com/images/logo.png"),
            tags: ["Next.js", "Vercel", "Open Source", "Supabase"]
        ),
        BlogPost(
            slug: "hire-tim-design-engineer-san-francisco",
            title: "Hire Tim: Design Engineer in San Francisco",
            date: "May 27, 2026",
            category: "Job Search",
            readTime: "5 min read",
            excerpt: "I am looking for Design Engineer and Frontend Engineer opportunities where I can help teams design, build, and ship polished web and mobile products.",
            coverImageUrl: url("https://hiretimsf.com/images/blog/small-marketing-campaigns-personal-branding/hiretimsf-work-card.webp"),
            imageAlt: "HireTimSF campaign graphic with Tim giving two thumbs up",
            url: url("https://hiretimsf.com/blog/hire-tim-design-engineer-san-francisco"),
            sections: [
                BlogPostSection(title: "What I build", content: "I build high-quality web and mobile apps with Next.js, React, TypeScript, Tailwind CSS, shadcn/ui, Supabase, Kotlin, Jetpack Compose, Swift, and SwiftUI."),
                BlogPostSection(title: "Recent work", content: "Recent work includes Choijin Temple Restaurant, Menu.ceo, a full-stack blog app with 460+ GitHub stars, and mobile portfolio apps for Android and iOS.")
            ],
            content: "",
            author: "Tim Baz",
            authorAvatarUrl: URL(string: "https://hiretimsf.com/images/logo.png"),
            tags: ["Design Engineer", "Frontend Engineer", "San Francisco", "React", "SwiftUI"]
        )
    ]

    static let appInfo = [
        AppInfoItem(title: "Current Version", text: "1.0"),
        AppInfoItem(title: "Build", text: "5"),
        AppInfoItem(title: "App Store ID", text: "6776402039")
    ]

    static let sourceCodeURL = url("https://github.com/hiretimsf/HireTimSF-iOS-App")
    static let privacyURL = url("https://hiretimsf.com/privacy")
    static let dataDeletionURL = url("https://hiretimsf.com/data-deletion")
    static let rateURL = url("https://apps.apple.com/app/id6776402039")

    private static func url(_ string: String) -> URL {
        guard let url = URL(string: string) else {
            preconditionFailure("Invalid bundled URL: \(string)")
        }
        return url
    }
}
