<!-- Copyright © 2019 Robert S. Davidson All Rights Reserved. See LICENSE file for license information. -->
<!DOCTYPE html>
<html lang="en">
<jsp:include page="../../includes/header.jsp">
	<jsp:param name="title" value="Sorting"/>
</jsp:include>
<body>
<jsp:include page="../../includes/navigation.jsp"/>

	<main role="main">
		<article class="post">
			<header>
				<h1>Sorting</h1>
				<time pubdate datetime="2019-03-22T08:00:00-04:00">March 22, 2019</time>
			</header>

			<p>Correct sorting is very important. Incorrect sorting often leads to subtle defects or sloppy display
				results. For some developers, sorting is an after thought. They don't give enough consideration to
				confirming their sort orders or to their code behind their sorting. </p>

			<h3>Definitive Sorting</h3>

			<p>It is best when sorting routines always yield the same result, regardless of of how often the sort is
				performed on the same data.</p>

			<p>Otherwise, repeated sorting may result in different orders. This may manifest when displaying data where
				two different rows unexpectedly switch order. Take for example a search results page, where the results
				are updated as the user types. Let's say the user is searching for contacts by last name. They type in
				<strong>Sm</strong> and sees the results:</p>

			<p>
				<code>Smith, Joe</code><br>
				<code>Smith, John</code><br>
				<code>Smith, Mary</code>
			</p>

			<p>Then the user types <strong>i</strong> for <strong>Smi</strong> but sees the results:</p>

			<p>
				<code>Smith, Mary</code><br>
				<code>Smith, Joe</code><br>
				<code>Smith, John</code>
			</p>

			<p>Notice <code>Smith, Mary</code> unexpectedly jumped to the top. This would be confusing to the user and
				would give the appearance of glitchy software.</p>

			<p>Less experienced developers often construct sort routines that touch 1 data point. That data point may
				not be unique. In the example above, the developer was only sorting on the last name.</p>

			<p>I use an approach where the last data point considered for sorting is against a unique data point. As
				such, if all previous data points are equal, the last data point will yield a non-equal comparison
				result, keeping the resulting sort order consistent.</p>

			<p>Consider our contacts are modeled in a <code>Person</code> class:</p>

<pre class="highlight"><code>class <span class="code-type">Person</span>
{
    private <span class="code-type">PersonID</span> <span class="code-variable">personID</span>;
    private <span class="code-type">String</span> <span class="code-variable">firstName</span>;
    private <span class="code-type">String</span> <span class="code-variable">lastName</span>;

    <span class="code-type">PersonID</span> getPersonID() { return <span class="code-variable">personID</span>; }
    <span class="code-type">String</span> getFirstName() { return <span class="code-variable">firstName</span>; }
    <span class="code-type">String</span> getLastName() { return <span class="code-variable">lastName</span>; }
}</code></pre>

			<p>The incorrect sort routine, only considering 1 data point, might look like this:</p>

<pre class="highlight"><code>class <span class="code-type">PersonList</span> extends <span class="code-type">ArrayList</span>&lt;<span class="code-type">Person</span>&gt;
{
    void sort()
    {
        sort(<span class="code-type">Comparator</span>.comparing(<span class="code-type">Person</span>::getLastName));
    }
}</code></pre>


			<p>When the last names are equal, and depending on the first name and PersonID values, the sort above may
				return varying results over repeated calls.</p>

			<p>However, we can achieve a definitive sort order by always including the unique PersonID as the last
				criteria in our sort:</p>

<pre class="highlight"><code>class <span class="code-type">PersonList</span> extends <span class="code-type">ArrayList</span>&lt;<span class="code-type">Person</span>&gt;
{
    void sort()
    {
        sort(<span class="code-type">Comparator</span>.comparing(<span class="code-type">Person</span>::getLastName)
            .thenComparing(<span class="code-type">Person</span>::getFirstName)
            .thenComparing(<span class="code-type">Person</span>::getPersonID));
    }
}</code></pre>

			<p>Often times, sorting issues are obvious when similar data is viewed in a display. But other times, the
				sorting maybe very subtle and not noticed on common data sets.</p>


			<h3>Code Reuse</h3>

			<p>In Java, given the ease of writing sorting code, developers often sort collections in the particular code
				where the sorting is needed. This can result in the same sorting code duplicated across the code base.
				This code is then harder to maintain and may result in issues, such as inconsistent sorting in different
				places.</p>

			<p>I like to encapsulate my sorting routines into my <em>List</em> objects. See my previous post, <a
				href="/blog/typesfordata/">Types for Modeling Data</a>, about the benefits of <em>List</em> objects.</p>

<pre class="highlight"><code>class <span class="code-type">PersonList</span> extends <span class="code-type">ArrayList</span>&lt;<span class="code-type">Person</span>&gt;
{
    void sort()
    {
        sort(<span class="code-type">Comparator</span>.comparing(<span class="code-type">Person</span>::getPersonID));
    }
}</code></pre>

			<p>Since your code will already have a <code>PersonList</code>, it's natural to call sort on the instance:
				</p>

<pre class="highlight"><code><span class="code-variable">personList</span>.sort();</code></pre>

			<p>Then supporting various sort orders is easy:</p>

<pre class="highlight"><code>class <span class="code-type">PersonList</span> extends <span class="code-type">ArrayList</span>&lt;<span class="code-type">Person</span>&gt;
{
    void sortByID()
    {
        sort(<span class="code-type">Comparator</span>.comparing(<span class="code-type">Person</span>::getPersonID));
    }

    void sortByFirstName()
    {
        sort(<span class="code-type">Comparator</span>.comparing(<span class="code-type">Person</span>::getFirstName)
            .thenComparing(<span class="code-type">Person</span>::getLastName)
            .thenComparing(<span class="code-type">Person</span>::getPersonID));
    }

    void sortByLastName()
    {
        sort(<span class="code-type">Comparator</span>.comparing(<span class="code-type">Person</span>::getLastName)
            .thenComparing(<span class="code-type">Person</span>::getFirstName)
            .thenComparing(<span class="code-type">Person</span>::getPersonID));
    }
}</code></pre>

			<h3>Extending Comparator</h3>

			<p>You can take the helper objects even further. Suppose you're building a UI and it needs to allow for user
				selected sorting. It would be convenient to be able to store the sort order in a variable. The variable
				then directs the UI to indicate to the user which order is currently selected and the same variable can
				drive the sort oder:</p>

<pre class="highlight"><code>class <span class="code-type">PersonComparator</span> implements <span class="code-type">Comparator</span>&lt;Person&gt;
{
    enum <span class="code-type">Order</span>
    {
        <span class="code-type">PersonID</span>(<span class="code-type">Comparator</span>.comparing(<span class="code-type">Person</span>::getPersonID)),
        <span class="code-type">FirstName</span>(<span class="code-type">Comparator</span>.comparing(<span class="code-type">Person</span>::getFirstName)),
            .thenComparing(<span class="code-type">Person</span>::getLastName))
            .thenComparing(<span class="code-type">Person</span>::getPersonID)),
        <span class="code-type">LastName</span>(<span class="code-type">Comparator</span>.comparing(<span class="code-type">Person</span>::getLastName)),
            .thenComparing(<span class="code-type">Person</span>::getFirstName))
            .thenComparing(<span class="code-type">Person</span>::getPersonID));

        private final <span class="code-type">Comparator</span>&lt;<span class="code-type">Person</span>&gt; <span class="code-variable">comparator</span>;

        <span class="code-type">Order</span>(<span class="code-type">Comparator</span>&lt;<span class="code-type">Person</span>&gt; <span class="code-variable">comparator</span>)
        {
            this.<span class="code-variable">comparator</span> = <span class="code-variable">comparator</span>;
        }
    };

    <span class="code-type">Order</span> <span class="code-variable">order</span> = <span class="code-type">Order</span>.<span class="code-type">LastName</span>;
    boolean <span class="code-variable">descending</span>;

    public int compare(<span class="code-type">Person</span> <span class="code-variable">o1</span>, <span class="code-type">Person</span> <span class="code-variable">o2</span>)
    {
        return <span class="code-variable">descending</span> ? <span class="code-variable">order</span>.<span class="code-variable">comparator</span>.compare(<span class="code-variable">o2</span>, <span class="code-variable">o1</span>)
            : <span class="code-variable">order</span>.<span class="code-variable">comparator</span>.compare(<span class="code-variable">o1</span>, <span class="code-variable">o2</span>);
    }
}</code></pre>


			<p>Then making use of a PersonComparator variable for sorting becomes pretty simple:</p>

<pre class="highlight"><code><span class="code-comment">// default sort</span>
<span class="code-type">PersonComparator</span> <span class="code-variable">personComparator</span> = new <span class="code-type">PersonComparator</span>();
<span class="code-variable">personList</span>.sort(<span class="code-variable">personComparator</span>);

<span class="code-comment">// change sort to first name, descending</span>
<span class="code-variable">personComparator</span>.order = <span class="code-type">PersonComparator</span>.Order.FirstName;
<span class="code-variable">personComparator</span>.descending = true;
<span class="code-variable">personList</span>.sort(<span class="code-variable">personComparator</span>);

<span class="code-comment">// change sort to PersonID</span>
<span class="code-variable">personComparator</span>.order = <span class="code-type">PersonComparator</span>.Order.PersonID;
<span class="code-variable">personComparator</span>.descending = false;
<span class="code-variable">personList</span>.sort(<span class="code-variable">personComparator</span>);
</code></pre>

		</article>

	</main>

<jsp:include page="../../includes/footer.jsp"/>

</body>
</html>