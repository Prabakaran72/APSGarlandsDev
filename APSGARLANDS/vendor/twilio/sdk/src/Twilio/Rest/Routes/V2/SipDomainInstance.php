<?php

/**
 * This code was generated by
 * \ / _    _  _|   _  _
 * | (_)\/(_)(_|\/| |(/_  v1.0.0
 * /       /
 */

namespace Twilio\Rest\Routes\V2;

use Twilio\Deserialize;
use Twilio\Exceptions\TwilioException;
use Twilio\InstanceResource;
use Twilio\Options;
use Twilio\Values;
use Twilio\Version;

/**
 * @property string $sipDomain
 * @property string $url
 * @property string $sid
 * @property string $accountSid
 * @property string $friendlyName
 * @property string $voiceRegion
 * @property \DateTime $dateCreated
 * @property \DateTime $dateUpdated
 */
class SipDomainInstance extends InstanceResource {
    /**
     * Initialize the SipDomainInstance
     *
     * @param Version $version Version that contains the resource
     * @param mixed[] $payload The response payload
     * @param string $sipDomain The sip_domain
     */
    public function __construct(Version $version, array $payload, string $sipDomain = null) {
        parent::__construct($version);

        // Marshaled Properties
        $this->properties = [
            'sipDomain' => Values::array_get($payload, 'sip_domain'),
            'url' => Values::array_get($payload, 'url'),
            'sid' => Values::array_get($payload, 'sid'),
            'accountSid' => Values::array_get($payload, 'account_sid'),
            'friendlyName' => Values::array_get($payload, 'friendly_name'),
            'voiceRegion' => Values::array_get($payload, 'voice_region'),
            'dateCreated' => Deserialize::dateTime(Values::array_get($payload, 'date_created')),
            'dateUpdated' => Deserialize::dateTime(Values::array_get($payload, 'date_updated')),
        ];

        $this->solution = ['sipDomain' => $sipDomain ?: $this->properties['sipDomain'], ];
    }

    /**
     * Generate an instance context for the instance, the context is capable of
     * performing various actions.  All instance actions are proxied to the context
     *
     * @return SipDomainContext Context for this SipDomainInstance
     */
    protected function proxy(): SipDomainContext {
        if (!$this->context) {
            $this->context = new SipDomainContext($this->version, $this->solution['sipDomain']);
        }

        return $this->context;
    }

    /**
     * Update the SipDomainInstance
     *
     * @param array|Options $options Optional Arguments
     * @return SipDomainInstance Updated SipDomainInstance
     * @throws TwilioException When an HTTP error occurs.
     */
    public function update(array $options = []): SipDomainInstance {
        return $this->proxy()->update($options);
    }

    /**
     * Fetch the SipDomainInstance
     *
     * @return SipDomainInstance Fetched SipDomainInstance
     * @throws TwilioException When an HTTP error occurs.
     */
    public function fetch(): SipDomainInstance {
        return $this->proxy()->fetch();
    }

    /**
     * Magic getter to access properties
     *
     * @param string $name Property to access
     * @return mixed The requested property
     * @throws TwilioException For unknown properties
     */
    public function __get(string $name) {
        if (\array_key_exists($name, $this->properties)) {
            return $this->properties[$name];
        }

        if (\property_exists($this, '_' . $name)) {
            $method = 'get' . \ucfirst($name);
            return $this->$method();
        }

        throw new TwilioException('Unknown property: ' . $name);
    }

    /**
     * Provide a friendly representation
     *
     * @return string Machine friendly representation
     */
    public function __toString(): string {
        $context = [];
        foreach ($this->solution as $key => $value) {
            $context[] = "$key=$value";
        }
        return '[Twilio.Routes.V2.SipDomainInstance ' . \implode(' ', $context) . ']';
    }
}