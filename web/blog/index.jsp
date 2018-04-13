<!-- Copyright (c) 2018 Robert S. Davidson. All Rights Reserved. See LICENSE file for license information. -->
<!DOCTYPE html>
<html lang="en">
<jsp:include page="../includes/header.jsp">
	<jsp:param name="title" value="Blog"/>
</jsp:include>
<body>
<jsp:include page="../includes/navigation.jsp"/>

	<main role="main">

		<article id="/blog/idtypes" class="summary">
			<header>
				<h1 class="title"><a href="/blog/idtypes/">Identifiers are Types</a></h1>
				<time pubdate datetime="2018-04-13T17:00:00-04:00">April 13, 2018</time>
			</header>
			<section class="excerpt">
				<p>Identifiers are unique types and should be treated as such in our code. In software, we create object
					types to model the world around us. We create unique object types to model specific data.
					Identifiers too are a model of a specific kind of data, with its own unique scope. The identifiers
					for one type of data is completely different than the identifiers in another type of data.</p>

				<a href="/blog/idtypes/">Read more...</a>
			</section>
		</article>

		<article id="/blog/naming" class="summary">
			<header>
				<h1 class="title"><a href="/blog/naming/">What's in a Name</a></h1>
				<time pubdate datetime="2018-03-23T12:00:00-04:00">March 23, 2018</time>
			</header>
			<section class="excerpt">
				<p>What's in a name? Well, everything. As developers, we spend a great deal of time reading code, both
					our own and other developers' code. We should be able to jump back into code written last week, a
					year ago or 10 years ago and be able to easily read it. This all starts with good naming.</p>


				<a href="/blog/naming/">Read more...</a>
			</section>
		</article>

	</main>

<jsp:include page="../includes/footer.jsp"/>
</body>
</html>
