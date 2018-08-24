<!-- Copyright © 2018 Robert S. Davidson All Rights Reserved. See LICENSE file for license information. -->
<!DOCTYPE html>
<html lang="en">
<jsp:include page="../../includes/header.jsp">
	<jsp:param name="title" value="Types for Modeling Data"/>
</jsp:include>
<body>
<jsp:include page="../../includes/navigation.jsp"/>

	<main role="main">
		<article class="post">
			<header>
				<h1>Types for Modeling Data</h1>
				<time pubdate datetime="2018-08-24T15:00:00-04:00">August 24, 2018</time>
			</header>

			<p>When developers have a new piece of data to handle, they will create a new type for that data. That's a
				pretty standard approach. But they often don't create new types to handle a <em>list</em> or
				<em>collection</em> of that data, or even a type for the identifier. Having these extra types can yield
				many benefits.</p>

			<h3>1 Thing - 3 Types</h3>

			<p>Whenever I need to create a type for a new piece a data, I always create 3 associated types. For the
				purpose of illustration, let's call them: <code>Thing</code>, <code>ThingID</code> and
				<code>ThingList</code>.</p>

			<p><code>Thing</code> - the type that encapsulates a single instance of the piece of data <br />
			<code>ThingID</code> - the type for the unique identifier of <code>Thing</code> <br />
			<code>ThingList</code> - the type for a collection of <code>Thing</code></p>

			<p>These 3 types work nicely together in code to handle many, if not most, situations.</p>

			<p>See my earlier blog entry <a href="/blog/idtypes/">Identifiers are Types</a>, for the benefits of
				<code>ThingID</code>.</p>

			<h3>List Benefits</h3>

			<p>Having a <code>ThingList</code> type allows for encapsulation of common list-related operations,
				improving code structure, readability and reuse. There are often cases where code is needed to iterate
				through a list, performing some operation such as filtering or updating. Many developers build this
				code in the place where it is used. If multiple places need the same logic, they often duplicate
				code.</p>

			<p>A better approach is to create a method on the <code>ThingList</code> type.</p>

			<p>Consider the need to filter a list for a particular <em>count</em> (i.e. some arbitrary attribute). In
				Java, this could be:</p>

<pre class="highlight"><code>class <span class="code-type">ThingList</span> extends <span class="code-type">ArrayList</span>&lt;<span class="code-type">Thing</span>&gt;
{
    <span class="code-type">ThingList</span> findByLessThanCount(<span class="code-type">int</span> <span class="code-variable">count</span>)
    {
        <span class="code-type">ThingList</span> <span class="code-variable">thingList</span> = new <span class="code-type">ThingList</span>();
        for (<span class="code-type">Thing</span> <span class="code-variable">thing</span> : <span class="code-variable">this</span>)
        {
            if (<span class="code-variable">thing</span>.count < <span class="code-variable">count</span>)
                <span class="code-variable">thingList</span>.add(<span class="code-variable">thing</span>);
        }
        return <span class="code-variable">thingList</span>;
    }
}</code></pre>

			<p>Often times, a map of <code>ThingID</code> to <code>Thing</code> is needed:</p>

<pre class="highlight"><code><span class="code-type">Map</span>&lt;<span class="code-type">ThingID</span>, <span class="code-type">Thing</span>&gt; convertToMap()
{
    <span class="code-type">Map</span>&lt;<span class="code-type">ThingID</span>, <span class="code-type">Thing</span>&gt; <span class="code-variable">thingMap</span> = new <span class="code-type">HashMap</span>&lt;&gt;();
    for (<span class="code-type">Thing</span> <span class="code-variable">thing</span> : <span class="code-variable">this</span>)
        <span class="code-variable">thingMap</span>.put(<span class="code-variable">thing</span>.thingID, <span class="code-variable">thing</span>);
    return <span class="code-variable">thingMap</span>;
}</code></pre>

		<p>Other times, we may want a set of <code>ThingID</code>:</p>

<pre class="highlight"><code><span class="code-type">Set</span>&lt;<span class="code-type">ThingID</span>&gt; getIDSet()
{
    <span class="code-type">Set</span>&lt;<span class="code-type">ThingID</span>&gt; <span class="code-variable">thingIDSet</span> = new <span class="code-type">HashSet</span>&lt;&gt;();
    for (<span class="code-type">Thing</span> <span class="code-variable">thing</span> : <span class="code-variable">this</span>)
        <span class="code-variable">thingIDSet</span>.add(<span class="code-variable">thing</span>.thingID);
    return <span class="code-variable">thingIDSet</span>;
}</code></pre>

			<p>The <code>ThingList</code> type is a very convenient and organized place for these methods to exist.</p>

			<h3>Reading and Writing Data</h3>

			<p>The <code>Thing</code> and <code>ThingList</code> types approach make reading and writing data much
				easier and very consistent across the code base.</p>

			<p>For all of my projects, I will have an abstract base type for reading and writing data, usually named
				<code>DataReader</code> and <code>DataWriter</code>, with derived concrete types for handling particular
				data types, such as <code>JsonDataReader</code>, <code>JsonDataWriter</code>,
				<code>XmlDataReader</code>, <code>XmlDataWriter</code>, <code>DatabaseDataReader</code> and
				<code>DatabaseDataWriter</code>.</p>

			<p>These types will expose read/write method for native types, such as <code>readInt</code>,
				<code>readDate</code> and <code>readBoolean</code>, as well as methods for complex types, such as
				<code>readObject</code> and <code>readList</code>.</p>

			<p>The <code>Thing</code> type makes use of <code>DataReader</code> and <code>DataWriter</code> to move data
				into and out of a specific instance, using one of two approaches.</p>


			<h4>Using Read/Write Methods</h4>

			<p>The first approach is to create 2 methods on <code>Thing</code>, one for reading and one for writing.
				In each method, every member of the type is read or written:</p>

<pre class="highlight"><code>@Override
public <span class="code-type">void</span> readFrom(<span class="code-type">DataReader</span> <span class="code-variable">reader</span>) throws <span class="code-type">Exception</span>
{
    <span class="code-variable">thingID</span> = <span class="code-variable">reader</span>.readDataID(<span class="code-constant">"ThingID"</span>, <span class="code-type">ThingID</span>.CtorDataID);
    <span class="code-variable">name</span> = <span class="code-variable">reader</span>.readString(<span class="code-constant">"Name"</span>, <span class="code-constant">NameMaxLength</span>);
}

@Override
public <span class="code-type">void</span> writeTo(<span class="code-type">DataWriter</span> <span class="code-variable">writer</span>) throws <span class="code-type">Exception</span>
{
    <span class="code-variable">writer</span>.writeDataID(<span class="code-constant">"ThingID"</span>, <span class="code-variable">thingID</span>);
    <span class="code-variable">writer</span>.writeString(<span class="code-constant">"Name"</span>, <span class="code-variable">name</span>, <span class="code-constant">NameMaxLength</span>);
}</code></pre>

			<p>This approach has the object directly controlling the field names of the data and the order the data is
				read or written. It also allows the type to be a little more <em>black-boxed</em>. For example, there
				may be fields of the type that should never be changed after the initial version is created (such as a
				reference ID to parent data). In this case, no <em>set</em> method needs to be provided for the member.
				This approach also allows for a single point of code execution after all of the members have been
				set.</p>

			<h4>Direct Field Access</h4>

			<p>A second approach is for the type members to be directly accessed for fetching or setting. In this
				situation, the source data is queried and then the public type members are queried and accessed. It
				allows for a little less code but also usually requires that all members have public <em>set</em>
				methods, whose names directly match the source data. This approach increases the possibility for
				defects.</p>


			<h3>Permanent Storage</h3>

			<p>In general, most data is stored as hierarchical data or as database data. The reading and writing
				approach above can work well in both situations (but with some differences).</p>

			<h4>Hierarchical Data</h4>

			<p>Hierarchical data is the model of data where some thing contains a combination of native data types,
				other things or lists of other things. <code>JSON</code> and <code>XML</code> are data formats that
				model hierarchical data. The <code>Thing</code> and <code>ThingList</code> types approach fit perfectly
				into this model.</p>

			<p>Let's say our <code>Thing</code> is a person. And for our project, for each person, we need to track
				their first and last names, their birth date, a list of addresses, and their children (who are also
				modeled as people).</p>

			<p>We create our three types as: <code>Person</code>, <code>PersonID</code>, and <code>PersonList</code>. In
				Java, this would be:</p>

<pre class="highlight"><code>class <span class="code-type">Person</span>
{
    <span class="code-type">PersonID</span> <span class="code-variable">personID</span>;
    <span class="code-type">String</span> <span class="code-variable">firstName</span>;
    <span class="code-type">String</span> <span class="code-variable">lastName</span>;
    <span class="code-type">Date</span> <span class="code-variable">birthDate</span>;
    <span class="code-type">AddressList</span> <span class="code-variable">addresses</span>;
    <span class="code-type">PersonList</span> <span class="code-variable">children</span>;
}

class <span class="code-type">PersonList</span> extends <span class="code-type">ArrayList</span>&lt;<span class="code-type">Person</span>&gt;
{
}</code></pre>

			<p>For our illustration, <code>Address</code>, <code>AddressID</code> and <code>AddressList</code> are the
				types to handle the address data.</p>

			<p>In JSON, a particular person might look like:</p>

<pre class="highlight"><code>{
    <span class="code-constant">"personID"</span>: <span class="code-constant">1234</span>,
    <span class="code-constant">"firstName"</span>: <span class="code-constant">"Michael"</span>,
    <span class="code-constant">"lastName"</span>: <span class="code-constant">"Smith"</span>,
    <span class="code-constant">"birthDate</span>": <span class="code-constant">"1990-01-01"</span>,
    <span class="code-constant">"address"</span>: [
    {
        <span class="code-constant">"Street1"</span>: <span class="code-constant">"123 Main St."</span>,
        <span class="code-constant">"City"</span>: <span class="code-constant">"Anytown"</span>,
        <span class="code-constant">"State"</span>: <span class="code-constant">"AA"</span>,
        <span class="code-constant">"PostalCode"</span>: <span class="code-constant">"99999"</span>
    },
    {
        <span class="code-constant">"Street1"</span>: <span class="code-constant">"456 Elm St."</span>,
        <span class="code-constant">"City"</span>: <span class="code-constant">"Anytown"</span>,
        <span class="code-constant">"State"</span>: <span class="code-constant">"AA"</span>,
        <span class="code-constant">"PostalCode"</span>: <span class="code-constant">"99999"</span>
    }],
    <span class="code-constant">"child"</span>: [
    {
        <span class="code-constant">"personID"</span>: <span class="code-constant">2345</span>,
        <span class="code-constant">"firstName"</span>: <span class="code-constant">"Mary"</span>,
        <span class="code-constant">"lastName"</span>: <span class="code-constant">"Smith"</span>,
        <span class="code-constant">"birthDate"</span>: <span class="code-constant">"2010-01-01"</span>
    },
    {
        <span class="code-constant">"personID"</span>: <span class="code-constant">3456</span>,
        <span class="code-constant">"firstName"</span>: <span class="code-constant">"Martin"</span>,
        <span class="code-constant">"lastName"</span>: <span class="code-constant">"Smith"</span>,
        <span class="code-constant">"birthDate"</span>: <span class="code-constant">"2012-01-01"</span>
    }]
}</code></pre>

			<p>Once the <code>readFrom</code> and <code>writeTo</code> methods have been created for these types,
				reading from a <code>JSON</code> string is a simple as:</p>

<pre class="highlight"><code><span class="code-variable">person</span> = new <span class="code-type">JsonDataReader</span>(<span class="code-variable">jsonString</span>).readObject(null, <span class="code-type">Person</span>.CtorDataReader);</code></pre>

			<h4>Database Data</h4>

			<p>Unlike hierarchical data, database data is essentially flat data, where a single piece of data is stored
				in a single table <em>row</em>. It's not easy to create types that work with both hierarchical and
				database data, but the <code>Thing</code> and <code>ThingList</code> approach still has many benefits
				when use for database data.</p>

			<p>Database library access APIs have historically been organized around a <em>record set</em> concept with
				their approach to SQL's <code>SELECT</code>, <code>INSERT</code>, <code>UPDATE</code> and
				<code>DELETE</code> calls. Those APIs are not object-oriented and programmers often get tripped up about
				the best way to move <em>record set</em> data to and from instances of object-oriented types, as well
				as, how those types should best handle their specific SQL calls.</p>

			<p>The <code>Thing</code> and <code>ThingList</code> approach, along with the <code>DataReader</code>,
				<code>DataWriter</code> approach above, can be use for database access and with a few simple rules, can
				go a long way to keeping the code efficient, readable, and maintainable.</p>

			<ul>
				<li>The <code>Thing</code> object should be used to encapsulate <code>SELECT</code>,
					<code>INSERT</code>,<code>UPDATE</code> and <code>DELETE</code> operations that affect a single
					record, such as when searching by a unique key, knowing that only a single record will be returned.
				</li>
				<li>The <code>ThingList</code> object should be used for any <code>SELECT</code> call that is not
					searching by a unique key, where 0, 1, or many records will be returned. Not as important, but for
					good for code organization, <code>ThingList</code> should also be used to encapsulate bulk SQL
					calls, such as bulk <code>UPDATE</code> or <code>DELETE</code> calls. These methods would be static
					methods on <code>ThingList</code> and would not actually pull any database record data into memory.
				</li>
			</ul>

			<p>All of the database library access calls would take place in a single type (or a small set of types).
				Lately, I have been calling this the <code>DatabaseAdaptor</code> type. As such, the <code>Thing</code>
				and <code>ThingList</code> types do not have code specific to the database library APIs.</p>

			<p>The <code>DatabaseAdaptor</code> type exposes methods for the single-record based <code>INSERT</code>,
				<code>UPDATE</code> and <code>DELETE</code> calls, as well as methods for performing <code>SELECT</code>
				calls, understanding multiple records will be returned. <code>DatabaseAdaptor</code> does not handle an
				explicit <code>Thing</code> type, but instead understands that data is read and written to memory via
				<code>DataReader</code> and <code>DataWriter</code>. This approach allows for very simple and concise
				<code>Thing</code> and <code>ThingList</code> code.</p>

			<p>In Java, our <code>Person</code> type would look something like:</p>

<pre class="highlight"><code>class <span class="code-type">Person</span> extends <span class="code-type">DatabaseObject</span>
{
    public static <span class="code-type">DatabaseAdaptor</span>&lt;<span class="code-type">Person</span>, <span class="code-type">PersonList</span>&gt; getDatabaseAdaptor()
        { return <span class="code-type">DatabaseAdaptor</span>.getDatabaseAdaptorForClass(
            <span class="code-type">Person</span>.class.getSimpleName()); }

    private <span class="code-type">PersonID</span> <span class="code-variable">personID</span>;
    private <span class="code-type">String</span> <span class="code-variable">firstName</span>;
    private <span class="code-type">String</span> <span class="code-variable">lastName</span>;
    private <span class="code-type">Date</span> <span class="code-variable">birthDate</span>;

    <span class="code-comment">// Constructor when creating a new instance, not yet stored</span>
    public <span class="code-type">Person</span>()
    {
        <span class="code-variable">personID</span> = <span class="code-type">PersonID</span>.newInstance();
    }

    <span class="code-comment">// Constructor when reading an instance from stored data, via DatabaseAdaptor</span>
    public <span class="code-type">Person</span>(<span class="code-type">DataReader</span> <span class="code-variable">reader</span>) throws <span class="code-type">Exception</span>
    {
        super(<span class="code-variable">reader</span>);
        readFrom(<span class="code-variable">reader</span>);
    }

    <span class="code-comment">// Fetches an existing stored Person when PersonID is known</span>
    public static <span class="code-type">Person</span> get(<span class="code-type">PersonID</span> <span class="code-variable">personID</span>) throws <span class="code-type">Exception</span>
    {
        return getDatabaseAdaptor().selectByKey(<span class="code-variable">personID</span>, <span class="code-type">DataExists</span>.MustExist);
    }

    @Override
    public void readFrom(<span class="code-type">DataReader</span> <span class="code-variable">reader</span>) throws <span class="code-type">Exception</span>
    {
        <span class="code-variable">personID</span> = <span class="code-variable">reader</span>.readDataID(<span class="code-constant">"PersonID"</span>, <span class="code-type">PersonID</span>.CtorDataID);
        <span class="code-variable">firstName</span> = <span class="code-variable">reader</span>.readString(<span class="code-constant">"FirstName"</span>, <span class="code-constant">NameMaxLength</span>);
        <span class="code-variable">lastName</span> = <span class="code-variable">reader</span>.readString(<span class="code-constant">"LastName"</span>, <span class="code-constant">NameMaxLength</span>);
        <span class="code-variable">birthDate</span> = <span class="code-variable">reader</span>.readDate(<span class="code-constant">"BirthDate"</span>);
    }

    @Override
    public void writeTo(<span class="code-type">DataWriter</span> <span class="code-variable">writer</span>) throws <span class="code-type">Exception</span>
    {
        <span class="code-variable">writer</span>.writeDataID(<span class="code-constant">"PersonID"</span>, <span class="code-variable">personID</span>);
        <span class="code-variable">writer</span>.writeString(<span class="code-constant">"FirstName"</span>, <span class="code-variable">firstName</span>, <span class="code-constant">NameMaxLength</span>);
        <span class="code-variable">writer</span>.writeString(<span class="code-constant">"LastName"</span>, <span class="code-variable">lastName</span>, <span class="code-constant">NameMaxLength</span>);
        <span class="code-variable">writer</span>.writeDate(<span class="code-constant">"BirthDate"</span>, <span class="code-variable">birthDate</span>);
    }

    public void update() throws <span class="code-type">Exception</span>
    {
        getDatabaseAdaptor().update(<span class="code-variable">this</span>);
    }

    public void delete() throws <span class="code-type">Exception</span>
    {
        getDatabaseAdaptor().delete(<span class="code-variable">personID</span>);
    }
}</code></pre>

			<p>Our <code>PersonList</code> type would look something like:</p>

<pre class="highlight"><code>public class <span class="code-type">PersonList</span> extends <span class="code-type">DatabaseObjectList</span>&lt;<span class="code-type">Person</span>&gt;
{
    public static <span class="code-type">PersonList</span> findByLastName(<span class="code-type">String</span> <span class="code-variable">lastName</span>) throws <span class="code-type">Exception</span>
    {
        if (!<span class="code-type">StrUtil</span>.hasLen(<span class="code-variable">lastName</span>))
            throw new <span class="code-type">IllegalArgumentException</span>(<span class="code-constant">"lastName is empty"</span>);

        <span class="code-type">DatabaseProcParam</span> <span class="code-variable">params</span>[] = new <span class="code-type">DatabaseProcParam</span>[1];
        <span class="code-variable">params</span>[0] = new <span class="code-type">DatabaseProcParam</span>(<span class="code-type">Types</span>.VARCHAR, <span class="code-variable">lastName</span>);

        return <span class="code-type">Person</span>.getDatabaseAdaptor().selectManyByProc(
            <span class="code-constant">"Person_GetByLastName"</span>, params);
    }
}</code></pre>

			<p>To see production projects where these approaches have been fully implemented, see my
				<a href="https://github.com/grtvd/inetvod">iNetVOD</a> projects on GitHub. They are Java-based projects,
				circa 2007 or so.</p>

		</article>

	</main>

<jsp:include page="../../includes/footer.jsp"/>

</body>
</html>