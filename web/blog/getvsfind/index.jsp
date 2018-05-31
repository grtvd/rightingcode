<!-- Copyright © 2018 Robert S. Davidson All Rights Reserved. See LICENSE file for license information. -->
<!DOCTYPE html>
<html lang="en">
<jsp:include page="../../includes/header.jsp">
	<jsp:param name="title" value="Identifiers are Types"/>
</jsp:include>
<body>
<jsp:include page="../../includes/navigation.jsp"/>

<main role="main">
	<article class="post">
		<header>
			<h1>Get vs. Find</h1>
			<time pubdate datetime="2018-05-30T21:00:00-04:00">May 30, 2018</time>
		</header>

		<p>Get vs. Find is a simple code naming convention for increasing code readability while decreasing code
			complexity, the amount of code written and potential defects. When fetching data, from something such as a
			list, map, set, or even permanent storage, the developer will <em>know</em> when the data being fetch should
			<em>always be found</em> (i.e.<code>gets</code>) or not (i.e. <code>finds</code>).</p>

		<p><code>Get</code> methods raise an exception if the data is not found, these methods will never return null.
			<br>
			<code>Find</code> methods will return null if the data is not found, these methods will not raise an
			exception.</p>

		<p>When calling a <code>get</code> method, there is no need to handle a null condition, reducing the need for
			extra logic.</p>

		<h3>Data Sorting Example</h3>

		<p>Let's take the following example where a list of addresses need to be sorted by the owner's name.</p>

<pre class="highlight"><code><span class="code-comment">// Address data class to be sorted</span>
<span class="code-type">class</span> Address
{
    <span class="code-type">PersonID</span> <span class="code-variable">personID</span>;
    <span class="code-type">String</span> <span class="code-variable">street</span>;
    <span class="code-type">String</span> <span class="code-variable">city</span>;
    <span class="code-type">StateID</span> <span class="code-variable">stateID</span>;
}

<span class="code-comment">// Person data class to aide in sorting</span>
<span class="code-type">class</span> Person
{
    <span class="code-type">PersonID</span> <span class="code-variable">personID</span>;
    <span class="code-type">String</span> <span class="code-variable">firstName</span>;
    <span class="code-type">String</span> <span class="code-variable">lastName</span>;
}
</code></pre>

		<p>We can assume <code>Person.personID</code> is a unique key and will always exist. And
			<code>Address.personID</code> will always refer to a valid <code>Person.personID</code>.</p>

		<p>To help with the sorting, we create a helper <code>PersonMap</code> class with our <code>get</code>
			and <code>find</code> methods, named <code>getByID</code> and <code>findByID</code>:</p>

<pre class="highlight"><code>class <span class="code-type">PersonMap</span> extends <span class="code-type">HashMap</span>&lt;<span class="code-type">PersonID</span>, <span class="code-type">Person</span>&gt;
{
    <span class="code-comment">// never returns null, raises an exception</span>
    public <span class="code-type">Person</span> getByID(<span class="code-type">PersonID</span> <span class="code-variable">personID</span>)
    {
        <span class="code-type">Person</span> <span class="code-variable">person</span> = super.get(<span class="code-variable">personID</span>);
        if (<span class="code-variable">person</span> != null)
            return <span class="code-variable">person</span>;

        throw new <span class="code-type">IllegalArgumentException</span>(<span class="code-constant">"Bad PersonID("</span> + <span class="code-variable">personID</span> + <span class="code-constant">")"</span>);
    }

    <span class="code-comment">// may return null</span>
    public <span class="code-type">Person</span> findByID(<span class="code-type">PersonID</span> <span class="code-variable">personID</span>)
    {
        return super.get(<span class="code-variable">personID</span>);
    }
}
</code></pre>

		<p>This class helps with creating the sorting (<code>Comparator</code>) class we need:</p>


<pre class="highlight"><code>class <span class="code-type">AddressSorter</span> implements <span class="code-type">Comparator</span>&lt;<span class="code-type">Address</span>&gt;
{
    <span class="code-type">PersonMap</span> <span class="code-variable">personMap</span>;

    public <span class="code-type">AddressSorter</span>(<span class="code-type">PersonMap</span> <span class="code-variable">personMap</span>)
    {
        this.<span class="code-variable">personMap</span> = <span class="code-variable">personMap</span>;
    }

    @Override
    public <span class="code-type">int</span> compare(<span class="code-type">Address</span> <span class="code-variable">o1</span>, <span class="code-type">Address</span> <span class="code-variable">o2</span>)
    {
        <span class="code-type">Person</span> <span class="code-variable">person1</span> = <span class="code-variable">personMap</span>.getByID(<span class="code-variable">o1</span>.<span class="code-variable">personID</span>);
        <span class="code-type">Person</span> <span class="code-variable">person2</span> = <span class="code-variable">personMap</span>.getByID(<span class="code-variable">o2</span>.<span class="code-variable">personID</span>);

        int <span class="code-type">compare</span> = <span class="code-variable">person1</span>.<span class="code-variable">lastName</span>.compareTo(<span class="code-variable">person2</span>.<span class="code-variable">lastName</span>);
        if (<span class="code-type">compare</span> != 0)
            return <span class="code-type">compare</span>;
        <span class="code-type">compare</span> = <span class="code-variable">person1</span>.<span class="code-variable">firstName</span>.compareTo(<span class="code-variable">person2</span>.<span class="code-variable">firstName</span>);
        if (<span class="code-type">compare</span> != 0)
            return <span class="code-type">compare</span>;
        return <span class="code-variable">person1</span>.<span class="code-variable">personID</span>.compareTo(<span class="code-variable">person2</span>.<span class="code-variable">personID</span>);
    }
}
</code></pre>

		<p>The resulting code is cleaner and removes the need to check for null when calling <code>getByID()</code>,
			knowing that null will never be returned (i.e. in practice of course unless there is a defect elsewhere).
			</p>

		<h3>The Alternative</h3>

		<p>If we did not take this approach, our code would need to confirm <code>person1</code> and
			<code>person2</code> are not null. We would need code such as:</p>

<pre class="highlight"><code>if ((<span class="code-variable">person1</span> == null) || (<span class="code-variable">person2</span> == null))
    throw new <span class="code-type">IllegalArgumentException</span>(<span class="code-constant">"Bad o1.personID or o2.personID");</span></code></pre>

		<p>We would need these null pointer checks in other similar code, whenever <code>Person</code> look-ups are
			performed. Having our <code>PersonMap</code> with its <code>get</code> and <code>find</code> methods removes
			a lot of similar, repetitive code.</p>

		<h3>Other Benefits</h3>

		<p>There are more benefits to <code>get</code> methods. Let's say there is a defect elsewhere and
			<code>getByID()</code> does not find it's <code>personID</code> parameter as expected. Our
			<code>getByID()</code> raises an intelligent exception, noting the bad <code>personID</code> value (as well
			as providing a consistent error message, regardless of the calling code). If the standard Java Map.get()
			were used, the code would just result in a null pointer.</p>

		<h3>Get or Find</h3>

		<p><code>Get</code> methods should only be used when the criteria is known to always exist. Having a unique key
			is a good indicator that <code>get</code> methods can be used.</p>

		<p>But be careful, the situation matters. There often are cases where provided values are expected to be unique
			keys but may not have been validated. Take for example code that validates user inputted data. Email
			addresses are unique keys, once they are validated. Consider an email address entered by a user. In this
			situation, a <code>find</code> method should be used to validate the email address. Using a <code>get</code>
			method on an invalid email address would raise an exception. Instead, a <code>find</code> method should be
			used and a null result handled.</p>

		<h3>Conclusion</h3>

		<p>The Get vs. Find approach will go a long way towards helping to build better, more stable code. And will
			result in less, better tested code.</p>


	</article>

</main>

<jsp:include page="../../includes/footer.jsp"/>

</body>
</html>