<!-- Copyright (c) 2019 Robert S. Davidson. All Rights Reserved. See LICENSE file for license information. -->
<!DOCTYPE html>
<html lang="en">
<jsp:include page="../includes/header.jsp">
	<jsp:param name="title" value="Blog"/>
</jsp:include>
<body>
<jsp:include page="../includes/navigation.jsp"/>

	<main role="main">

		<article id="/blog/redundant" class="summary">
			<header>
				<h1 class="title"><a href="/blog/redundant/">Avoid Redundant Calls</a></h1>
				<time pubdate datetime="2019-09-27T11:00:00-04:00">September 27, 2019</time>
			</header>
			<section class="excerpt">
				<p>It's important as developers that we are careful to not make unnecessary, redundant method calls.
					During code reviews, I often come across situations where code is doing this extra, unneeded work.
					In the short term, it may make the code slightly slower. But longer term, as code is updated for
					future versions, redundant calls could have more drastic effects on performance.</p>

				<a href="/blog/redundant/">Read more...</a>
			</section>
		</article>

		<article id="/blog/sorting" class="summary">
			<header>
				<h1 class="title"><a href="/blog/sorting/">Sorting</a></h1>
				<time pubdate datetime="2019-03-22T08:00:00-04:00">March 22, 2019</time>
			</header>
			<section class="excerpt">
				<p>Correct sorting is very important. Incorrect sorting often leads to subtle defects or sloppy display
					results. For some developers, sorting is an after thought. They don't give enough consideration to
					confirming their sort orders or to their code behind their sorting. </p>

				<a href="/blog/sorting/">Read more...</a>
			</section>
		</article>

		<article id="/blog/typesfordata" class="summary">
			<header>
				<h1 class="title"><a href="/blog/typesfordata/">Types for Modeling Data</a></h1>
				<time pubdate datetime="2018-08-24T15:00:00-04:00">August 24, 2018</time>
			</header>
			<section class="excerpt">
				<p>When developers have a new piece of data to handle, they will create a new type for that data. That's
					a pretty standard approach. But they often don't create new types to handle a <em>list</em> or
					<em>collection</em> of that data, or even a type for the identifier. Having these extra types can
					yield many benefits.</p>

				<a href="/blog/typesfordata/">Read more...</a>
			</section>
		</article>

		<article id="/blog/getvsfind" class="summary">
			<header>
				<h1 class="title"><a href="/blog/getvsfind/">Get vs. Find</a></h1>
				<time pubdate datetime="2018-05-30T21:00:00-04:00">May 30, 2018</time>
			</header>
			<section class="excerpt">
				<p>Get vs. Find is a simple code naming convention for increasing code readability while decreasing code
					complexity, the amount of code written and potential defects. When fetching data, from something
					such as a list, map, set, or even permanent storage, the developer will <em>know</em> when the data
					being fetch should <em>always be found</em> (i.e.<code>gets</code>) or not (i.e.
					<code>finds</code>).</p>

				<a href="/blog/getvsfind/">Read more...</a>
			</section>
		</article>

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
