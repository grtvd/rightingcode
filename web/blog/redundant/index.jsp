<!-- Copyright © 2019 Robert S. Davidson All Rights Reserved. See LICENSE file for license information. -->
<!DOCTYPE html>
<html lang="en">
<jsp:include page="../../includes/header.jsp">
	<jsp:param name="title" value="Avoid Redundant Calls"/>
</jsp:include>
<body>
<jsp:include page="../../includes/navigation.jsp"/>

	<main role="main">
		<article class="post">
			<header>
				<h1>Avoid Redundant Calls</h1>
				<time pubdate datetime="2019-09-27T11:00:00-04:00">September 27, 2019</time>
			</header>

			<p>It's important as developers that we are careful to not make unnecessary, redundant method calls. During
				code reviews, I often come across situations where code is doing this extra, unneeded work. In the
				short term, it may make the code slightly slower. But longer term, as code is updated for future
				versions, redundant calls could have more drastic effects on performance.</p>


			<p>In a simple situation, the same <code>getLocalData()</code> method is called twice, for no particular
				reason:</p>

<pre class="highlight"><code><span class="code-type">Data</span> fetchData()
{
    if (getLocalData() != null)
        return getLocalData().getData();
    return null;
}</code></pre>

			<p>This should have been written as:</p>

<pre class="highlight"><code><span class="code-type">Data</span> fetchData()
{
    <span class="code-type">ComplexData</span> <span class="code-variable">data</span> = getLocalData();
    if (<span class="code-variable">data</span> != null)
        return <span class="code-variable">data</span>.getData();
    return null;
}</code></pre>

			<p>Sometimes programmers think this is not much of a problem, because perhaps they know that
				<code>getLocalData()</code> is pretty simple:</p>

<pre class="highlight"><code><span class="code-type">ComplexData</span> getLocalData()
{
    return <span class="code-variable">data</span>;
}</code></pre>

			<p>But we run into problems with code maintainability and update ability. Let's say for the next version of
				the code, when the functional requirements change, and <code>getLocalData()</code> now has to access an
				external data repository, or something much slower than simple memory access. That original double call
				to <code>getLocalData()</code> can have a much bigger effect.</p>

			<p>That effect is magnified when the method is called in a loop. Take this code for example:</p>

<pre class="highlight"><code>void processData()
{
    for (<span class="code-type">Item</span> <span class="code-variable">item</span> : <span class="code-variable">list</span>)
    {
        process(getLocalData(), <span class="code-variable">item</span>)
    }
}</code></pre>


			<p>Developers often test against smaller data sets than found in production environments. I've seen
				situations were a developer was repeatedly calling a method that accessed a database. In this local
				testing, there was no performance problem, because the data set was small. But in production, on a much
				larger data set, his new code made the application unusable.</p>

			<p>I recently came across code similar to this:</p>

<pre class="highlight"><code><span class="code-type">boolean</span> hasAny()
{
    if ((findTheData() != null) && (findTheData().size() > <span class="code-constant">0</span>))
        return <span class="code-constant">true</span>;
    return <span class="code-constant">false</span>;
}</code></pre>

			<p>In this situation, <code>findTheData()</code> was a complex method, doing lots of work, but the developer
				didn't pick up on the issue of the double, redundant call. This should be a red flag to any reader of
				this code.</p>

			<p>This also highlights where good helper methods come into play. Developers often write code in the
				pattern: <code>(list != null) && (list.size() > 0)</code>. A simple <code>isEmpty()</code> helper
				benefits this code:

<pre class="highlight"><code>static <span class="code-type">boolean</span> isEmpty(<span class="code-type">Collection</span> <span class="code-variable">collection</span>)
{
    return (<span class="code-variable">collection</span> == null) || (<span class="code-variable">collection</span>.size() == <span class="code-constant">0</span>);
}</code></pre>

			<p>This helper removes the double call to <code>findTheData()</code>, by forcing the result into a parameter
				variable. The <code>hasAny()</code> method can become:</p>

<pre class="highlight"><code><span class="code-type">boolean</span> hasAny()
{
    return !isEmpty(findTheData());
}</code></pre>

			<h3>Conclusion</h3>

			<p>It is important for developers to really consider the method calls in their code and think about the
				effects of those calls.</p>

		</article>

	</main>

<jsp:include page="../../includes/footer.jsp"/>

</body>
</html>