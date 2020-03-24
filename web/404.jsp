<!-- Copyright (c) 2020 Robert S. Davidson. All Rights Reserved. See LICENSE file for license information. -->
<!DOCTYPE html>
<html lang="en">
<jsp:include page="includes/header.jsp">
	<jsp:param name="title" value="Page Not Found"/>
</jsp:include>
<body>
<jsp:include page="includes/navigation.jsp"/>

	<main role="main">
		<article>
			<header>
				<h1>Page Not Found</h1>
			</header>

			<p>Where would you like to go:</p>

			<p><a href="/">Home</a><br>
			<a href="/about/">About</a><br>
			<a href="/blog/">Blog</a></p>
		</article>
	</main>

<jsp:include page="includes/footer.jsp"/>
</body>
</html>
