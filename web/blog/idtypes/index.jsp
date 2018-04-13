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
				<h1>Identifiers are Types</h1>
				<time pubdate datetime="2018-04-13T17:00:00-04:00">April 13, 2018</time>
			</header>

			<p>Identifiers are unique types and should be treated as such in our code. In software, we create object
				types to model the world around us. We create unique object types to model specific data.
				Identifiers too are models of a specific kind of data, with its own unique scope. The identifiers for
				one type of data are completely different than the identifiers in another type of data. A string of
				numbers representing a social security number is different from a string of numbers representing a
				phone number, and is different from a string of numbers representing a driver's license number. As
				such, these all should be modeled differently in our code.</p>

			<p>Some developers have a tendency to declared identifiers using native language types, such as
				<code>Integer</code>, <code>int</code> and <code>String</code>. This approach has huge downsides. Not
				only is the code less readable, it opens the code to a great deal of accidental mistakes.</p>


			<h3>Identifier Types</h3>

			<p>A much better approach than native language types is to declare unique types for each type of identifier.
				This approach has many benefits. Variable declaration makes the code's intention explicit. Method
				parameters are explicit and enforced. Instances are not mistakenly crossed assigned (i.e. assigning an
				identifier of one type to an identifier of a completely different type). The resulting code is
				significantly more readable and maintainable.</p>


			<h3>Clear Variable Declarations</h3>

			<p>Unique identifier types make the code much clearer than using native types.</p>

			<p>Let's say we are building a contact management system and we need identifiers for the people and their
				various addresses. Let's say we called these identifiers <code>personID</code> and
				<code>addressID</code>, referring to each unique instance of this data.
			</p>

			<p>Often, developers will declared these variables as:</p>

<pre class="highlight"><code><span class="code-comment">// Using native types</span>
<span class="code-type">int</span> <span class="code-variable">personID</span>;
<span class="code-type">int</span> <span class="code-variable">addressID</span>;</code></pre>

	<p>or maybe:</p>

<pre class="highlight"><code><span class="code-comment">// Using native types</span>
<span class="code-type">String</span> <span class="code-variable">personID</span>;
<span class="code-type">String</span> <span class="code-variable">addressID</span>;</code></pre>

			<p>These are good variable names, but what if the developer was not so clear with their variable naming:</p>

<pre class="highlight"><code><span class="code-comment">// Confusing, variables not named as identifiers</span>
<span class="code-type">String</span> <span class="code-variable">person</span>;
<span class="code-type">String</span> <span class="code-variable">address</span>;</code></pre>

			<p>What if these unclear names were used a method parameters:</p>

<pre class="highlight"><code><span class="code-comment">// Confusing method parameters</span>
void associate(<span class="code-type">String</span> <span class="code-variable">person</span>, <span class="code-type">String</span> <span class="code-variable">address</span>)</code></pre>

			<p>This sort of approach will lead to more problems.</p>

			<p>Using identifier types is much clearer:</p>

<pre class="highlight"><code><span class="code-comment">// Clear identifier types and variables</span>
<span class="code-type">PersonID</span> <span class="code-variable">personID</span>;
<span class="code-type">AddressID</span> <span class="code-variable">addressID</span>;</code></pre>

			<p>Even if the variable names are misleading:</p>

<pre class="highlight"><code><span class="code-comment">// Clear identifier types</span>
<span class="code-type">PersonID</span> <span class="code-variable">person</span>;
<span class="code-type">AddressID</span> <span class="code-variable">address</span>;</code></pre>

<pre class="highlight"><code><span class="code-comment">// Clear method parameter types</span>
void associate(<span class="code-type">PersonID</span> <span class="code-variable">person</span>, <span class="code-type">AddressID</span> <span class="code-variable">address</span>)</code></pre>


			<h3>Better Method Declarations</h3>

			<p>Unique identifier types solve a big problem with method declarations involving identifiers.</p>

			<p>For example, maybe our contact management system allows for people and addresses to be linked. Let's say
				<code>personID</code> and <code>addressID</code> variables are both declared as <code>int</code> and
				there is an<code>associate</code> methods that takes both parameters:</p>

<pre class="highlight"><code><span class="code-comment">// Example method using native types</span>
<span class="code-type">int</span> <span class="code-variable">personID</span>;
<span class="code-type">int</span> <span class="code-variable">addressID</span>;
void associate(<span class="code-type">int</span> <span class="code-variable">personID</span>, <span class="code-type">int</span> <span class="code-variable">addressID</span>)</code></pre>

			<p>It would be very easy to accidentally flip the parameters when calling the method:</p>

<pre class="highlight"><code><span class="code-comment">// Parameters mistakenly reversed</span>
associate(<span class="code-variable">addressID</span>, <span class="code-variable">personID</span>);</code></pre>

			<p>This would not give any compile error, allowing the mistake to be built into the executable. Testing for
				this condition can also be a challenge. Since <code>personID</code> and <code>addressID</code> are both
				integers, it is highly likely the approach for assigning new values starts at 1 and increases. The
				result is that both<code>personID</code> and <code>addressID</code> would share very similar value
				domains. For example, both could have a value of 10, even if they are completely independent of each
				other. Calling the <code>associate</code>method with mixed up identifiers could manifest in very odd
				ways, making the code defect very hard to locate.</p>

			<p>Identifier types have another benefit to methods. It is very common practice to overload methods with
				similar but different parameters. For example, there may be a third identifier, such as a
				<code>FamilyID</code>, and perhaps we want a variation to the <code>associate</code> method:</p>

<pre class="highlight"><code><span class="code-comment">// Can't overload associate method when using native types</span>
void associate(<span class="code-type">int</span> <span class="code-variable">familyID</span>, <span class="code-type">int</span> <span class="code-variable">addressID</span>)</code></pre>

			<p>This new method would fail to compile since it is syntactically the same as
				<code>void associate(int personID, int addressID)</code>.</p>

			<p>But this approach works when using identifier types:</p>

<pre class="highlight"><code><span class="code-comment">// Overloaded associate method allowed</span>
void associate(<span class="code-type">PersonID</span> <span class="code-variable">personID</span>, <span class="code-type">AddressID</span> <span class="code-variable">addressID</span>)
void associate(<span class="code-type">FamilyID</span> <span class="code-variable">familyID</span>, <span class="code-type">AddressID</span> <span class="code-variable">addressID</span>)</code></pre>


			<h3>Additional Validation</h3>

			<p>Another benefit of identifier types is additional validation. For types based on <code>Strings</code>,
				I consider it illegal to allow for an empty <code>String</code> as the internal value. I also validate
				my <code>String</code> values against a maximum length. These identifiers are often stored in database
				tables and we normally limit our table columns to a specific length.</p>

			<p>For types based on <code>Integers</code>, we validate when converting a string representation to an
				integer. It's obvious there are many string values that do not covert to integers. We may also know a
				specific identifier type has a limited value domain, so we can validate for that domain.</p>

			<p>On a recent project I had to store the country with an address. There is an ISO standard for country
				codes, so it made sense that the country values would be a unique type, such as <code>CountryID</code>.
				When I'm reading the <code>CountryID</code> values from JSON or XML, there is nothing stopping the
				creator from sending bad values. My <code>CountryID</code> validates against valid ISO values.</p>


			<h3>Constant Comparisons</h3>

			<p>We often have constants for various identifier types. By having a true identifier type, we can define the
				constant part of the type, giving it a well-defined scope, making the code more logical and easier to
				read.</p>

			<p>For example, our <code>CountryID</code> needed a <code>US</code> constant so code could understand USA
				addresses:</p>

<pre class="highlight"><code><span class="code-comment">// Constants can be defined in type's scope</span>
public class <span class="code-type">CountryID</span>
{
    public static final <span class="code-type">CountryID</span> <span class="code-variable">US</span> = new <span class="code-type">CountryID</span>(<span class="code-constant">"US"</span>);
}</code></pre>

			<p>USA addresses require a State to be specified, so I ended up with UI logic to understand when to display
				the State field:</p>

<pre class="highlight"><code>if (<span class="code-type">CountryID</span>.<span class="code-variable">US</span>.equals(<span class="code-variable">countryID</span>))</code></pre>


			<h3>Immutable Identifier Types</h3>

			<p>Instances of identifier types should be immutable. The value of the identifier should be set when the
				instance is created. Access to the internal value of the identifier should be limited. Most of the code
				written against the instances should avoid any logic that depends on understanding the internal value
				(most code should not need to care about the internal value). Code generally only needs the type to
				support reading/writing to string values. This allows support for external formats such as JSON, XML,
				HTML, etc. and allows writing values to log files. Database access may require calls based on native
				types, but these can usually be encapsulated in a small amount of specific code.</p>


			<h3>Java Example</h3>

			<p>Let me illustrate how I handle this approach in Java code.</p>

			<p>I usually have a <code>DataID</code> abstract class:</p>

<pre class="highlight"><code>public abstract class <span class="code-type">DataID</span>
{
}</code></pre>

			<p>Since the Java base Object class provides the <code>public String toString()</code> method, there is no
				need for another method to fetch the identifier as a string value. Each identifier class will need to
				provide a constructor taking a <code>String</code> parameter. Together these allow common code to access
				and use identifier instances without knowing or caring about its internal value.</p>

			<p>Then I'll have <code>StringID</code> and <code>IntegerID</code> abstract classes implementing the
				<code>DataID</code> protocol, whose purpose is to maintain an internal value of <code>String</code> and
				<code>int</code> respectively.</p>

<pre class="highlight"><code>public abstract class <span class="code-type">StringID</span> extends <span class="code-type">DataID</span>
public abstract class <span class="code-type">IntegerID</span> extends <span class="code-type">DataID</span></code></pre>

			<p>To allow <code>StringID</code> and <code>IntegerID</code> to behave more like native types and so they work correctly for maps, sets, comparisons, etc., I'll include overrides for:</p>

<pre class="highlight"><code>public boolean equals(<span class="code-type">Object</span> <span class="code-variable">o</span>)
public int hashCode()</code></pre>

			<p>and implement the <code>Comparable</code> interface:</p>

<pre class="highlight"><code>... implements <span class="code-type">Comparable</span>&lt;<span class="code-type">StringID</span>&gt;
public int compareTo(<span class="code-type">StringID</span> <span class="code-variable">o</span>)</code></pre>

<pre class="highlight"><code>... implements <span class="code-type">Comparable</span>&lt;<span class="code-type">IntegerID</span>&gt;
public int compareTo(<span class="code-type">IntegerID</span> <span class="code-variable">o</span>)</code></pre>

			<p>The resulting classes will look something like:</p>

<pre class="highlight"><code>public abstract class <span class="code-type">StringID</span> extends <span class="code-type">DataID</span> implements <span class="code-type">Comparable</span>&lt;<span class="code-type">StringID</span>&gt;
{
    private final <span class="code-type">String</span> <span class="code-variable">fValue</span>;

    public <span class="code-type">StringID</span>(<span class="code-type">String</span> <span class="code-variable">value</span>)
    {
        if ((<span class="code-variable">value</span> == null) || (<span class="code-variable">value</span>.length() == <span class="code-constant">0</span>))
            throw new <span class="code-type">IllegalArgumentException</span>(<span class="code-constant">"value is undefined"</span>);

        <span class="code-variable">fValue</span> = <span class="code-variable">value</span>;
    }

    @Override
    public <span class="code-type">String</span> toString()
    {
        return <span class="code-variable">fValue</span>;
    }

    @Override
    public <span class="code-type">boolean</span> equals(<span class="code-type">Object</span> <span class="code-variable">o</span>)
    {
        if (!(<span class="code-variable">o</span> instanceof <span class="code-type">StringID</span>))
            return <span class="code-constant">false</span>;

        return <span class="code-variable">fValue</span>.equals(((<span class="code-type">StringID</span>)<span class="code-variable">o</span>).<span class="code-variable">fValue</span>);
    }

    @Override
    public <span class="code-type">int</span> hashCode()
    {
        return <span class="code-variable">fValue</span>.hashCode();
    }

    @Override
    public <span class="code-type">int</span> compareTo(<span class="code-type">StringID</span> <span class="code-variable">o</span>)
    {
        if (<span class="code-variable">o</span> == null)
            return <span class="code-constant">1</span>;

        return <span class="code-variable">fValue</span>.compareTo(<span class="code-variable">o</span>.<span class="code-variable">fValue</span>);
    }
}</code></pre>


<pre class="highlight"><code>public abstract class <span class="code-type">IntegerID</span> extends <span class="code-type">DataID</span> implements <span class="code-type">Comparable</span>&lt;<span class="code-type">IntegerID</span>&gt;
{
    private final <span class="code-type">int</span> <span class="code-variable">fValue</span>;
    private final <span class="code-type">String</span> <span class="code-variable">fValueStr</span>;

    public <span class="code-type">IntegerID</span>(<span class="code-type">Integer</span> <span class="code-variable">value</span>)
    {
        if (<span class="code-variable">value</span> == null)
            throw new <span class="code-type">IllegalArgumentException</span>(<span class="code-constant">"value is undefined"</span>);

        <span class="code-variable">fValue</span> = <span class="code-variable">value</span>;
        <span class="code-variable">fValueStr</span> = <span class="code-type">Integer</span>.toString(<span class="code-variable">fValue</span>);
    }

    public <span class="code-type">IntegerID</span>(<span class="code-type">String</span> <span class="code-variable">value</span>)
    {
        if ((<span class="code-variable">value</span> == null) || (<span class="code-variable">value</span>.trim().length() == <span class="code-constant">0</span>))
            throw new <span class="code-type">IllegalArgumentException</span>(<span class="code-constant">"value is undefined"</span>);

        <span class="code-variable">fValue</span> = <span class="code-type">Integer</span>.decode(<span class="code-variable">value</span>.trim());
        <span class="code-variable">fValueStr</span> = <span class="code-type">Integer</span>.toString(<span class="code-variable">fValue</span>);
    }

    public <span class="code-type">int</span> toInteger()
    {
        return <span class="code-variable">fValue</span>;
    }

    @Override
    public <span class="code-type">String</span> toString()
    {
        return <span class="code-variable">fValueStr</span>;
    }

    @Override
    public <span class="code-type">boolean</span> equals(<span class="code-type">Object</span> <span class="code-variable">o</span>)
    {
        if (!(<span class="code-variable">o</span> instanceof <span class="code-type">IntegerID</span>))
            return <span class="code-constant">false</span>;

        return <span class="code-variable">fValue</span> == ((<span class="code-type">IntegerID</span>)<span class="code-variable">o</span>).<span class="code-variable">fValue</span>;
    }

    @Override
    public <span class="code-type">int</span> hashCode()
    {
        return <span class="code-variable">fValueStr</span>.hashCode();
    }

    @Override
    public <span class="code-type">int</span> compareTo(<span class="code-type">IntegerID</span> <span class="code-variable">o</span>)
    {
        if (<span class="code-variable">o</span> == null)
            return <span class="code-constant">1</span>;

        return <span class="code-variable">Integer</span>.compare(<span class="code-variable">fValue</span>, <span class="code-variable">o</span>.<span class="code-variable">fValue</span>);
    }
}</code></pre>

			<p>With <code>IntegerID</code>, I've added <code>public IntegerID(Integer value)</code> and
				<code>public int toInteger()</code>. These aren't strictly needed, but are nice helpers when serializing
				IntegerID via code that explicitly supports native types, such as JDBC.</p>

			<p>In some projects, I'll have additional base identifier types, such as <code>UUStringID</code>, which
				understands <code>UUID</code> values represented as strings, and <code>UUBinaryID</code>, which
				understands <code>UUID</code> values as <code>byte[]</code>.</p>

			<p>As I noted above, an additional validation for <code>StringID</code> might be to check the length of the
				string value. There are two changes to <code>StringID</code> for this. First, an abstract
				<code>getMaxLength()</code> method is added:</p>

<pre class="highlight"><code>public abstract <span class="code-type">int</span> getMaxLength();</code></pre>

			<p>Second, the <code>StringID(String value)</code> constructor adds the validation:</p>

<pre class="highlight"><code><span class="code-type">int</span> <span class="code-variable">maxLength</span> = getMaxLength();
if (<span class="code-variable">value</span>.length() > getMaxLength())
    throw new <span class="code-type">IllegalArgumentException</span>(<span class="code-type">String</span>.format(
        <span class="code-constant">"value(%s) length(%d) greater than max(%d)"</span>, <span class="code-variable">value</span>,
        <span class="code-variable">value</span>.length(), <span class="code-variable">maxLength</span>));</code></pre>


			<p>Now that our base types are defined, the application specific classes are pretty simple:</p>

<pre class="highlight"><code>public class <span class="code-type">ApplicationID</span> extends <span class="code-type">StringID</span>
{
    public <span class="code-type">ApplicationID</span> (<span class="code-type">String</span> <span class="code-variable">value</span>)
    {
        super(<span class="code-variable">value</span>);
    }

    @Override
    public <span class="code-type">int</span> getMaxLength() { return <span class="code-constant">32</span>; }
}</code></pre>


			<h3>Initialization</h3>

			<p>The final piece is handling common code that needs to construct new instances of our <code>DataID</code>
				without having to know the concrete derived class. In Java, I handle this using the
				<code>Constructor</code> class. My identifier types expose a <code>Constructor</code> constant:</p>

<pre class="highlight"><code>public static final <span class="code-type">Constructor</span>&lt;<span class="code-type">ApplicationID</span>&gt; <span class="code-variable">CtorDataID</span>
    = <span class="code-type">CtorUtil</span>.getCtorString(<span class="code-type">ApplicationID</span>.class);</code></pre>

			<p>Then I may have a class for reading JSON data, which provides a methods for reading a
				<code>DataID</code>:</p>

<pre class="highlight"><code>public &lt;<span class="code-type">T</span> extends <span class="code-type">DataID</span>&gt; <span class="code-type">T</span> readDataID(<span class="code-type">String</span> <span class="code-variable">fieldName</span>,
    <span class="code-type">Constructor</span>&lt;<span class="code-type">T</span>&gt; <span class="code-variable">ctorDataID</span>) throws <span class="code-type">Exception</span></code></pre>

			<p>Likewise, I may have a class for writing JSON data, where a <code>writeDataID()</code> method can make
				use of the <code>toString()</code> method provided.</p>

			<p>This approach simplifies reading and writing identifier values, adds validation, both while hiding the
				internal implementation of the identifier's value.</p>

			<h3>Conclusion</h3>

			<p>Using identifier types over native types has many benefits. The resulting code will contain far fewer
				errors, be more readable and more maintainable for years to come.</p>

		</article>

	</main>

<jsp:include page="../../includes/footer.jsp"/>

</body>
</html>