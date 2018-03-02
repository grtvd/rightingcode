<!-- Copyright (c) 2018 Robert S. Davidson. All Rights Reserved. See LICENSE file for license information. -->
<!DOCTYPE html>
<html lang="en">
<jsp:include page="includes/header.jsp">
	<jsp:param name="title" value="Hello"/>
</jsp:include>
<body>
<jsp:include page="includes/navigation.jsp"/>

	<main role="main">
		<article>
			<header>
				<h1>Hello</h1>
			</header>

			<p>Righting Code is a blog about writing code, the right way. Software should be written that will last
				decades. It should be as readable, expandable and maintainable in the 10th or 20th year as the 1st
				year. It should be as readable, expandable and maintainable whether 1 person has developed it or 100
				people have. Regardless of the project size, a developer should be able freely to move to any part of
				the project and be productive updating the code. A developer should be able to read any other
				developer's code and understand what it is doing. It should not be obvious which developer created a
				particular piece of code.</p>

			<p>Many developers don't have the mindset that software should be built for the long term. In 1990, I was a
				consultant to Prodigy working on a proprietary fantasy baseball game. I noticed their developers were
				using 2 digits to store years (which would cause issues once 2000 arrived). I pressed the Prodigy team
				to use 4-digit years. One of the developers told me the game would never make it 2000. Well, the game,
				<a href="http://www.baseballmanager.com" target="_blank">Baseball Manager</a>, is still being played
				today, still using the original game engine I wrote in 1990.</p>

			<p>I've have seen countless projects fail because of lack of techniques, lack of organization and general
				lack of understanding how to solve certain problems. Even software that "works" is often not
				maintainable. These projects are built like a house of cards, without a good foundation. A problem in
				a piece of fundamental code can bring the entire project down. Many developers understand the basics
				of writing code, but they don't understand how to write readable and maintainable code.</p>

			<p>I hope some of this will help you in your projects.</p>

			<p>Bob</p>
		</article>

	</main>

<jsp:include page="includes/footer.jsp"/>
</body>
</html>
